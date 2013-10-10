class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :status_id, null: false
      t.integer :user_id, null: false
      t.text :body

      t.timestamps
    end

    add_index :responses, :status_id
    add_index :responses, :user_id
  end
end
