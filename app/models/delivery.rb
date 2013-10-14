class Delivery < ActiveRecord::Base
  attr_accessible :message_id, :user_id

  validates :message_id, :user_id, presence: true
  validates :message_id, uniqueness: { scope: :user_id }

  belongs_to :message
  belongs_to :user
end
