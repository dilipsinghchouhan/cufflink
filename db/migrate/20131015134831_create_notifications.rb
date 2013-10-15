class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notifiable_type, null: false
      t.integer :notifiable_id, null: false
      t.integer :user_id, null: false
      t.integer :string_1
      t.integer :string_2
      t.boolean :unread, default: true
      t.boolean :email, default: true
      t.boolean :notify, default: true

      t.timestamps
    end

    add_index :notifications, :notifiable_type
    add_index :notifications, :notifiable_id
    add_index :notifications, :notify
    add_index :notifications, :unread
    add_index :notifications, :user_id
  end
end
