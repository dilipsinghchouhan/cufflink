class Education < ActiveRecord::Base
  attr_accessible :school, :school_id, :city, :state, :start_date, :end_date,
    :current_student, :agra, :degree, :awards, :owner_id

  validates :owner_id, presence: true

  belongs_to :owner, class_name: "User"
end
