class Education < ActiveRecord::Base
  attr_accessible :school, :city, :state, :start_date, :end_date,
    :current_student, :string_1, :string_2, :body, :owner_id, :null,
    :position

  validates :state, inclusion: { in: %w(NY CA), allow_nil: true }
  validates :city, :string_1, :string_2, :body, length: { minimum: 1, allow_nil: true }
  validates :school, length: { minimum: 1 }, uniqueness: { scope: :owner_id }

  validate :no_time_travel

  validates :owner_id, presence: true

  belongs_to :owner, class_name: "User"

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
        "No time travel! Start date must be after end date.")
    end
  end

  def null=(field)
    self.send("#{field}=", nil)
  end

  #am i doing this?

  def self.positions
    Education.where("position IS TRUE")
  end

  def self.schools
    Education.where("position IS FALSE")
  end
end
