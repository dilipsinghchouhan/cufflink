class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :tagline, :city, :state,
    :industry, :summary, :null
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

  validates :name, :email, :status, :session_token, presence: true
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

  def self.gen_session_token
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

  def connections
    self.requested_connections + self.received_connections
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
    self.session_token = self.class.gen_session_token
    self.save!
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.gen_session_token
  end

end
