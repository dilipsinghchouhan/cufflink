class Response < ActiveRecord::Base
  validates :body, length: { minimum: 1, allow_nil: true }
  validate :like_is_unique

  belongs_to :user
  belongs_to :status

  has_many :notifications, as: :notifiable, dependent: :destroy

  after_create :create_response_notification!

  def like_is_unique
    return if body

    if Response.likes.find_by_user_id_and_status_id(user_id, status_id)
      errors.add(:user_id,
        "Cannot like the same status twice.")
    end
  end

  def is_like?
    !body
  end

  def self.likes
    Response.where("responses.body IS NULL")
  end

  def self.comments
    Response.where("responses.body IS NOT NULL")
  end

  def create_response_notification!
    self.notifications.create(user_id: self.status.user_id)
  end

end
