class AddEdColumn < ActiveRecord::Migration
  def change
    add_column :experiences, :position, :boolean, default: false
    add_index :experiences, :position
  end
end
