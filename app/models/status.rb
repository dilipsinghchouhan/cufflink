class Status < ActiveRecord::Base
  attr_accessible :body, :link, :image_url

  validate :user_id_or_company_id
  validate :one_field_filled_out

  def user_id_or_company_id
    user_id || company_id
  end

  def one_field_filled_out
    body || link || image_url
  end

  belongs_to :user
  belongs_to :company

  def is_company_status?
    self.company_id
  end
end
