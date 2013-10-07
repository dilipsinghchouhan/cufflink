class User < ActiveRecord::Base
  attr_accessible :name, :email, :password
  attr_reader :password

  validates :password_digest, presence: { message: "Password can't be blank." }
  validates :name, :email, :status, :session_token, presence: true
  validates :email, uniqueness: true #make it an email? regex?

  validates :password, length: { minimum: 6, allow_nil: true }
  #require a complex password?

  after_initialize :ensure_session_token

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
