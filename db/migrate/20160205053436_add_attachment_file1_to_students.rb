class AddAttachmentFile1ToStudents < ActiveRecord::Migration
  def self.up
    change_table :students do |t|
      t.attachment :file1
    end
  end

  def self.down
    remove_attachment :students, :file1
  end
end
