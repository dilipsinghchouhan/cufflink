class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :user_id
      t.integer :company_id
      t.text :body
      t.string :link
      t.string :image_url

      t.timestamps
    end

    add_index :statuses, :user_id
    add_index :statuses, :company_id
  end
end
