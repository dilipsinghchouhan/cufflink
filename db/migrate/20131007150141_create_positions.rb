class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :owner_id, null: false
      t.string :title, null: false
      t.string :company, default: ""
      t.integer :company_id, default: 0
      t.string :industry
      t.string :city
      t.string :state
      t.date :state_date
      t.date :end_date
      t.boolean :current_position, default: false
      t.text :description

      t.timestamps
    end
  end
end
