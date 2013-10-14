class RemovesImageUrl < ActiveRecord::Migration
  def change
    remove_column :statuses, :image_url

    rename_column :experiences, :area, :string_1
    rename_column :experiences, :degree, :string_2
    rename_column :experiences, :awards, :body
  end

end
