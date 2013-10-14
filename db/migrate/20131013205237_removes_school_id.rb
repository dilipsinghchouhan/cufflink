class RemovesSchoolId < ActiveRecord::Migration
  def change
    remove_column :experiences, :name_id
  end
end
