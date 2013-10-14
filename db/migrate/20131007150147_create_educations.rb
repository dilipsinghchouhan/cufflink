class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :owner_id, null: false
      t.string :name, default: ""
      t.integer :name_id
      t.string :city
      t.string :state
      t.date :start_date
      t.date :end_date
      t.boolean :current, default: false
      t.string :area
      t.string :degree
      t.text :awards

      t.timestamps
    end

    add_index :experiences, :owner_id
  end
end
