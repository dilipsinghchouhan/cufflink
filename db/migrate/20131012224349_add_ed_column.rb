class AddEdColumn < ActiveRecord::Migration
  def change
    add_column :experiences, :position, :boolean, default: false
  end
end
