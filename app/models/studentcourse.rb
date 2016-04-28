class Studentcourse < ActiveRecord::Base
  has_attached_file :course1
  has_attached_file :course2
  has_attached_file :teachexp
  validates_attachment :course1, content_type: { content_type: ["application/pdf","image/png", "image/jpg", "image/jpeg"] }
  validates_attachment :course2, content_type: { content_type: ["application/pdf","image/png", "image/jpg", "image/jpeg"] }
  validates_attachment :teachexp, content_type: { content_type: ["application/pdf","image/png", "image/jpg", "image/jpeg"] }
end
