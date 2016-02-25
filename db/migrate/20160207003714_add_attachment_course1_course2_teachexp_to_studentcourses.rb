class AddAttachmentCourse1Course2TeachexpToStudentcourses < ActiveRecord::Migration
  def self.up
    change_table :studentcourses do |t|
      t.attachment :course1
      t.attachment :course2
      t.attachment :teachexp
    end
  end

  def self.down
    remove_attachment :studentcourses, :course1
    remove_attachment :studentcourses, :course2
    remove_attachment :studentcourses, :teachexp
  end
end
