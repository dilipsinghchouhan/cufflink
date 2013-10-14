class Friendship < ActiveRecord::Base
  attr_accessible :friendee_id, :friender_id, :message,
  :connection_type, :token, :status

  validates :status, inclusion: { in: [0, 1, 2] }
  validates :friender_id, :friendee_id, :message, :connection_type,
    presence: true
  validates :friender_id, uniqueness: { scope: :friendee_id }

  belongs_to :friender, class_name: "User"
  belongs_to :friendee, class_name: "User"

  after_create :send_connection_request_email

  def send_connection_request_email
    begin
      token = User.gen_random_token
    end while Friendship.where('token = ?', token).length == 1

    self.update_attributes(token: token)

    msg = UserMailer.connection_request_email(self)
    msg.deliver!
  end
end
