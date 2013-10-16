class Message < ActiveRecord::Base
  attr_accessible :user_id, :company_id, :subject, :body

  validates :subject, :body, presence: true, length: { minimum: 5 }
  validate :user_id_or_company_id

  has_many :deliveries
  has_many :recipients, through: :deliveries, source: :user
  belongs_to :user
  belongs_to :company

  def author
    self.company ? self.company : self.user
  end

  def get_delivery(user)
    self.deliveries.find_by_user_id(user.id)
  end

  def received_by?(user)
    self.recipients.include?(user)
  end

  def sent_by?(user)
    !received_by?(user)
  end

  private

  def user_id_or_company_id
    unless user_id || company_id
      errors.add(:user_id, "Must belong to user or company")
    end
  end
end
