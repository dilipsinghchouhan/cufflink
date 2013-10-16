class Contact < ActiveRecord::Base
  attr_accessible :user_id, :company_id, :name, :value, :contact_type

  validates :value, :contact_type, presence: true

  validate :user_id_or_company_id, :contact_values

  belongs_to :user
  belongs_to :company

  # def self.contact_info_by_id(id, type, is_company)
  #   id_name = is_company ? "company_id" : "user_id"
  #
  #   Contact.where("contact_type is ? AND #{id_name} is ?", type, id)
  # end

  private

  def user_id_or_company_id
    unless user_id || company_id
      errors.add(:user_id, "Must belong to user or company")
    end
  end

  def contact_values

    case contact_type

    #email
    when 0
      unless /\A[a-zA-Z][\w\.]*@\w+\.\w+\z/.match(value)
        errors.add(:value, "Please enter a valid email")
      end

    #phone number
    when 1
      unless /\A\d?[\-\.]?\d{3}[\-\.]?\d{3}[\-\.]?\d{4}\z/.match(value)
        errors.add(:value, "Please enter a valid phone number")
      end

    #website
    when 2
      unless /\A((http:\/\/)|(https:\/\/))?((www\.)|\w+\.)?\w*(\.\w{2,4})\z/
        .match(value)
          errors.add(:value, "Please enter a valid URL")
      end
    end
  end




end
