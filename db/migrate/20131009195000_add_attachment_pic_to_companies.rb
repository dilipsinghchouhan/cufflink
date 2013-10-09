class AddAttachmentPicToCompanies < ActiveRecord::Migration
  def self.up
    change_table :companies do |t|
      t.attachment :pic
    end
  end

  def self.down
    drop_attached_file :companies, :pic
  end
end
