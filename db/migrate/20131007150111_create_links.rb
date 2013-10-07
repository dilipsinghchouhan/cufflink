class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :owner_id, null: false
      t.string :title
      t.string :url, null: false
      t.string :type, null: false

      t.timestamps
    end
  end
end
