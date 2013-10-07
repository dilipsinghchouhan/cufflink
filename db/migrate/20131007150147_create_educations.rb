class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.integer :owner_id, null: false
      t.string :school, default: ""
      t.integer :school_id, default: 0
      t.string :city
      t.string :state
      t.date :start_date
      t.date :end_date
      t.boolean :current_student, default: false
      t.string :area
      t.string :degree
      t.text :awards

      t.timestamps
    end
  end
end
