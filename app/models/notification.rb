class Notification < ActiveRecord::Base
  attr_accessible :notifiable_type, :user_id, :notifiable_id,
    :string_1, :string_2

  validates :notifiable_type, :notifiable_id, :user_id, presence: true
  validates :unread, :email, :notify, :inclusion => { :in => [true, false] }

  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  before_create :make_room_for_notification

  def self.unread_notification_count(user)
    count = Notification.unread_notifications(user).count
    count > 0 ? count.to_s : ""
  end

  def self.active_notification_count(user)
    count = Notification.active_notifications(user).count
    count > 0 ? count.to_s : ""
  end

  def self.active_notifications(user)
    user
      .notifications
      .where("notify IS TRUE")
  end

  def self.unread_notifications(user)
    user
      .notifications
      .where("unread IS TRUE AND notify IS TRUE")
  end

  def unread?
    self.unread
  end

  def make_room_for_notification

  end
end
