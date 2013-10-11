class RemovesImageUrl < ActiveRecord::Migration
  def change
    remove_column :statuses, :image_url

    rename_column :educations, :area, :string_1
    rename_column :educations, :degree, :string_2
    rename_column :educations, :awards, :body
  end

end
