class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.integer :owner_id, null: false
      t.string :number, null: false
      t.string :type, null: false

      t.timestamps
    end

    add_index :phone_numbers, :owner_id
  end
end
