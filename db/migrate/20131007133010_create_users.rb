class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false
      t.string :tagline
      t.text :summary
      t.string :city
      t.string :state
      t.string :industry
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :users, :session_token
    add_index :users, :email
  end
end
