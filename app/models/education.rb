class Education < ActiveRecord::Base
  attr_accessible :school, :school_id, :city, :state, :start_date, :end_date,
    :current_student, :string_1, :string_2, :body, :owner_id, :null

  validates :state, inclusion: { in: %w(NY CA), allow_nil: true }
  validates :school, :city, :string_1, :string_2, :body, length:
    { minimum: 1, allow_nil: true }
  validate :no_time_travel

  validates :owner_id, presence: true

  belongs_to :owner, class_name: "User"

  def no_time_travel
    return unless start_date && end_date
    if start_date > end_date
      errors.add(:start_date,
        "No time travel! Start date must be after end date.")
    end
  end

  def null=(field)
    self.send("#{field}=", nil)
  end
end
