class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.integer :company_id
      t.string :name
      t.string :value, null: false
      t.integer :type, null: false

      t.timestamps
    end

    add_index :contacts, :user_id
    add_index :contacts, :company_id
  end
end
