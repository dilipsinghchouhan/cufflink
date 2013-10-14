class RenamesExperienceStuff < ActiveRecord::Migration
  def change
    rename_table :experiences, :experiences
    rename_column :experiences, :name, :name
    rename_column :experiences, :current, :current
  end
end
