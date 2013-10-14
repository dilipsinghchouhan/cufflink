class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.integer :message_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :deliveries, :message_id
    add_index :deliveries, :user_id
  end
end
