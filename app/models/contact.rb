class Contact < ActiveRecord::Base
  attr_accessible :user_id, :company_id, :name, :value, :contact_type

  validates :value, :contact_type, presence: true

  validate :user_id_or_company_id

  belongs_to :user
  belongs_to :company

  # def self.contact_info_by_id(id, type, is_company)
  #   id_name = is_company ? "company_id" : "user_id"
  #
  #   Contact.where("contact_type is ? AND #{id_name} is ?", type, id)
  # end

  private

  def user_id_or_company_id
    user_id || company_id
  end
end
