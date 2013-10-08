class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :friender_id, null: false
      t.integer :friendee_id, null: false
      t.text :message, null: false
      t.string :connection_type, null: false
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :friendships, :friender_id
    add_index :friendships, :friendee_id
  end
end
