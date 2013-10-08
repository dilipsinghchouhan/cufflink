class Friendship < ActiveRecord::Base
  attr_accessible :friendee_id, :message, :connection_type

  validates :status, inclusion: { in: [0, 1, 2] }
  validates :friender_id, :friendee_id, :message, :connection_type,
    presence: true
  validates :friender_id, uniqueness: { scope: :friendee_id }

  belongs_to :friender, class_name: "User"
  belongs_to :friendee, class_name: "User"
end
