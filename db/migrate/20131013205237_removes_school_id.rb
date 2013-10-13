class RemovesSchoolId < ActiveRecord::Migration
  def change
    remove_column :educations, :school_id
  end
end
