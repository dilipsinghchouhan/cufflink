class RenamesEducationStuff < ActiveRecord::Migration
  def change
    rename_table :educations, :experiences
    rename_column :experiences, :school, :name
    rename_column :experiences, :current_student, :current
  end
end
