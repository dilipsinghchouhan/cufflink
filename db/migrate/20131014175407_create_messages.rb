class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :company_id
      t.string :subject, default: "(no subject)"
      t.text :body, null: false

      t.timestamps
    end

    add_index :messages, :user_id
    add_index :messages, :company_id
  end
end
