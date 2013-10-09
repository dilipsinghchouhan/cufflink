require 'company'
class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password, :tagline, :city,
    :state, :industry, :summary, :null
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

  has_many :educations, foreign_key: :owner_id

  has_many :requested_friendships, class_name: "Friendship",
    foreign_key: :friender_id

  has_many :received_friendships, class_name: "Friendship",
    foreign_key: :friendee_id

  has_many :requested_connections, through: :requested_friendships,
    source: :friendee

  has_many :received_connections, through: :received_friendships,
    source: :friender

  has_many :memberships, foreign_key: :member_id
  has_many :companies, through: :memberships, source: :company

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

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def connections
    connections = self.requested_connections + self.received_connections
    connections.select do |user|
      friendship = Friendship.find_by_friender_id_and_friendee_id(
        self.id, user.id)
      friendship && friendship.status == 1
    end
  end

  def owned_companies
    [].tap do |owned_companies|
      self.memberships.each do |membership|
        if membership.status == 2
          owned_companies << membership.company
        end
      end
    end
  end

  def friendship_status_with(user)
    return :connected if self.connections.include?(user)

    friendship = Friendship.find_by_friender_id_and_friendee_id(
      self.id, user.id)

    return :not_connected unless friendship

    return (friendship.status == 0) ? :pending : :denied
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

end
