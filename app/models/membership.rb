class Membership < ActiveRecord::Base
  attr_accessible :company_id, :member_id, :status

  validates :company_id, :member_id, :status, presence: true

  belongs_to :company
  belongs_to :member, class_name: "User", foreign_key: :member_id
end
