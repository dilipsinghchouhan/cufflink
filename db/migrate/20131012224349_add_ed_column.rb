class AddEdColumn < ActiveRecord::Migration
  def change
    add_column :educations, :position, :boolean, default: false
  end
end
