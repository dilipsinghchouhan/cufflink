class Response < ActiveRecord::Base
  validates :body, length: { minimum: 1, allow_nil: true }
  validate :like_is_unique

  belongs_to :user
  belongs_to :status

  def like_is_unique
    return if body

    if Response.find_by_user_id_and_status_id(user_id, status_id)
      errors.add(:user_id,
        "Cannot like the same status twice.")
    end
  end

  def self.likes
    Response.where("responses.body IS NULL")
  end

  def self.comments
    Response.where("responses.body IS NOT NULL")
  end

end
