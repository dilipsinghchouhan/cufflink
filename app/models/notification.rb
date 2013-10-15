class Notification < ActiveRecord::Base
  attr_accessible :notifiable_type, :user_id, :notifiable_id,
    :string_1, :string_2

  validates :notifiable_type, :notifiable_id, :user_id, :unread, :email,
    :notify, presence: true

  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  def self.unread_notification_count(user)
    Notification.unread_notifications(user).count > 0 ? count.to_s : ""
  end

  def self.unread_notifications(user)
    user
      .notifications
      .where("unread IS TRUE AND notify IS TRUE")
  end

  def unread?
    self.unread
  end
end
