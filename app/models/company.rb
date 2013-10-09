class Company < ActiveRecord::Base
  attr_accessible :owner, :name, :industry, :address1, :address2, :city,
    :state, :zip, :description

  validates :name, presence: true

  validates :name, :address1, :address2, :city, :zip, :description,
    length: { minimum: 1, allow_nil: true }

  validates :state, inclusion: { in: %w(NY CA), allow_nil: true }
  validates :industry, inclusion: { in: [
      "Real Estate",
      "Technology",
      "Advertising",
      "Hospitality",
      "Health/Medicine",
      "Banana Stand",
      "Other"
    ] }

  has_many :memberships, foreign_key: :company_id
  has_many :members, through: :memberships, source: :member

  def owner=(owner)
  end
end
