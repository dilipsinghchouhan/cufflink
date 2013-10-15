class Delivery < ActiveRecord::Base
  attr_accessible :message_id, :user_id, :unread

  validates :message_id, :user_id, presence: true
  validates :message_id, uniqueness: { scope: :user_id }

  belongs_to :message
  belongs_to :user

  def self.unread_message_count(user)
    count = user.deliveries.where("unread IS TRUE").count
    count > 0 ? count.to_s : ""
  end

  def unread?
    self.unread
  end

  def mark_as_read!
    self.unread = false
    self.save
  end
end
