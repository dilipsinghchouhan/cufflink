class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :company_id, null: false
      t.integer :member_id, null: false
      t.integer :status, default: 0
      t.timestamps
    end

    add_index :memberships, :company_id
    add_index :memberships, :member_id
  end
end
