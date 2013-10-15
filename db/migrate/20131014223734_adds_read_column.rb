class AddsReadColumn < ActiveRecord::Migration
  def change
    add_column :deliveries, :unread, :boolean, default: true
  end
end
