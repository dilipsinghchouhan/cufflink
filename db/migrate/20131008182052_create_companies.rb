class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :industry, null: false
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip

      t.text :description

      t.timestamps
    end
  end
end
