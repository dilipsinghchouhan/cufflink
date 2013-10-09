class FixColName < ActiveRecord::Migration
  def change
    rename_column :companies, :description, :summary
  end
end
