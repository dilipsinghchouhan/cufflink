class Experience < ActiveRecord::Base
  attr_accessible :name, :city, :state, :start_date, :end_date,
    :current, :string_1, :string_2, :body, :owner_id, :null, :position

  validates :state, inclusion: { in: %w(NY CA), allow_nil: true }
  validates :city, :string_1, :string_2, :body, length: { minimum: 1, allow_nil: true }
  validates :name, length: { minimum: 1 }, uniqueness: { scope: :owner_id }

  validate :no_time_travel

  validates :owner_id, presence: true

  belongs_to :owner, class_name: "User"

  after_create :company_followup

  def company_followup
    return unless self.position

    company = Company.find_by_name(self.name)

    unless company
      company = Company.create(name: self.name, industry: "Other")
    end

    unless company.members.include?(self.owner)
      Membership.create(
        company_id: company.id,
        member_id: self.owner_id
      )
    end
  end

  def no_time_travel
    [start_date, end_date].each do |date|
      next unless date

      if date > DateTime.now
        errors.add(
          date == start_date ? :start_date : :end_date,
          "Dates cannot be in the future"
          )
      end
    end

    return unless start_date && end_date
    if start_date > end_date
      errors.add(:start_date,
        "No time travel! Start date must be after end date")
    end
  end

  def null=(field)
    self.send("#{field}=", nil)
  end
end
