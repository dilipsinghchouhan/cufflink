class Education < ActiveRecord::Base
  attr_accessible :school, :school_id, :city, :state, :start_date, :end_date,
    :current_student, :area, :degree, :awards, :owner_id, :null

  validates :owner_id, presence: true

  belongs_to :owner, class_name: "User"

  def null=(field)
    self.send("#{field}=", nil)
  end
end
