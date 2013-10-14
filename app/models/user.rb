require 'company'
class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password, :tagline, :city,
    :state, :industry, :summary, :null, :pic
  attr_reader :password

  validates :password_digest, presence: { message: "Password can't be blank." }

  validates :tagline, :city, :summary, length: { minimum: 1, allow_nil: true }
  validates :state, inclusion: { in: %w(NY CA), allow_nil: true }
  validates :industry, inclusion: { in: [
      "Real Estate",
      "Technology",
      "Advertising",
      "Hospitality",
      "Health/Medicine",
      "Banana Stand",
      "Other"
    ], allow_nil: true }

  validates :first_name, :last_name, :email, :status, :session_token,
    presence: true
  validates :email, uniqueness: true #make it an email? regex?

  validates :password, length: { minimum: 6, allow_nil: true }
  #require a complex password?

  after_initialize :ensure_session_token
  after_create :create_contact_object

  has_many :experiences, foreign_key: :owner_id

  has_many :friendships, class_name: "Friendship",
    foreign_key: :friendee_id

  has_many :possible_connections, through: :friendships,
    source: :friender

  has_many :memberships, foreign_key: :member_id
  has_many :companies, through: :memberships, source: :company

  has_many :statuses
  has_many :responses
  has_many :contacts

  has_many :deliveries
  has_many :sent_messages, class_name: "Message"
  has_many :received_messages, through: :deliveries, source: :message

  has_attached_file :pic, styles: {
    big: "300x300>",
    thumb: "100x100>"
  }, default_url: "/assets/blue-myself.png"

  def self.gen_random_token
    SecureRandom::urlsafe_base64
  end

  def self.find_by_credentials(email, password)
    potential_user = User.find_by_email(email)
    if potential_user && potential_user.is_password?(password)
      potential_user
    else
      nil
    end
  end

  def self.find_by_name(name)
    names = name.split(" ")

    User.find_by_first_name_and_last_name(names[0], names[1])
  end

  def positions
    self.experiences.where("position IS TRUE")
  end

  def names
    self.experiences.where("position IS FALSE")
  end

  def likes
    Response.likes.where("user_id = ?", self.id)
  end

  def comments
    Response.comments.where("user_id = ?", self.id)
  end

  def connections
    self.possible_connections.where("friendships.status = 1")
  end

  def connections_with_statuses
    self.connections.includes(:statuses)
  end

  def get_feed_data
    data = {}

    self.connections_with_statuses.each do |connection|
      connection.statuses.each do |status|
        data[status] = connection
      end
    end

    statuses_by_time = data.keys.sort do |s1, s2|
      s2.created_at <=> s1.created_at
    end

    [data, statuses_by_time]

    #friends updates
    #friends profile changes

    #companies updates
    #companies profile changes

    #likes and comments on my statuses/updates
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def owned_companies
    owned_or_managed_companies(2)
  end

  def managed_companies
    owned_or_managed_companies(1)
  end

  def owned_or_managed_companies(status)
    [].tap do |companies|
      self.memberships.each do |membership|
        if membership.status >= status
          companies << membership.company
        end
      end
    end
  end

  def friendship_status_with(user)
    return :connected if self.connections.include?(user)

    requested_friendship =
      Friendship.find_by_friender_id_and_friendee_id(self.id, user.id)

    if requested_friendship
      return (requested_friendship.status == 0) ? :request_pending : :denied
    else

      received_friendship =
        Friendship.find_by_friendee_id_and_friender_id(self.id, user.id)

      if received_friendship
        return (received_friendship.status == 0) ? :receipt_pending : :denied

      else
        return :not_connected
      end
    end
  end

  def null=(field)
    self.send("#{field}=", nil)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = self.class.gen_random_token
    self.save!
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.gen_random_token
  end

  def create_contact_object
    Contact.create(
      user_id: self.id,
      value: self.email,
      name: "Primary",
      contact_type: 0
      )
  end

end
