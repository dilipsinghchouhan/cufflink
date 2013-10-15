class AddsColumntoResponses < ActiveRecord::Migration
  def change
    change_table :responses do |t|
      t.references :notifiable, polymorphic: true
    end
  end
end
