class Message < ActiveRecord::Base
  attr_accessible :user_id, :company_id, :subject, :body

  validates :subject, :body, presence: true
  validate :user_id_or_company_id

  private

  def user_id_or_company_id
    user_id || company_id
  end
end
