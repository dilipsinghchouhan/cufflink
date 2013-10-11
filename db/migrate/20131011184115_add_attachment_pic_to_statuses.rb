class AddAttachmentPicToStatuses < ActiveRecord::Migration
  def self.up
    change_table :statuses do |t|
      t.attachment :pic
    end
  end

  def self.down
    drop_attached_file :statuses, :pic
  end
end
