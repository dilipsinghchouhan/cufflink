class AddTokenColumn < ActiveRecord::Migration
  def change
    add_column :friendships, :token, :string
    add_index :friendships, :token
  end
end
