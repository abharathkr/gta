class Student < ActiveRecord::Base

  has_attached_file :file1
  validates_attachment :file1, content_type: { content_type: "application/pdf" }

end
