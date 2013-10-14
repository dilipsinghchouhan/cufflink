class Message < ActiveRecord::Base
  attr_accessible :user_id, :company_id, :subject, :body

  validates :subject, :body, presence: true, length: { minimum: 5 }
  validate :user_id_or_company_id

  has_many :deliveries
  has_many :recipients, through: :deliveries, source: :user
  belongs_to :user
  belongs_to :company

  private

  def user_id_or_company_id
    user_id || company_id
  end
end
