class AdminMailer < ApplicationMailer

  def success_mail(email,studentcourses,student)
  	@studentcourses = studentcourses
  	@student = student
  	attachments["Course1."+@studentcourses.course1_content_type.split("/")[1]] = { :data => File.read(@studentcourses.course1.path), :mime_type => @studentcourses.course1_content_type }
  	attachments["Course2."+@studentcourses.course2_content_type.split("/")[1]] = { :data => File.read(@studentcourses.course2.path), :mime_type => @studentcourses.course2_content_type }
  	attachments["Experience."+@studentcourses.teachexp_content_type.split("/")[1]] = { :data => File.read(@studentcourses.teachexp.path), :mime_type => @studentcourses.teachexp_content_type }
  	mail(to: email , subject: "Student Request Received")
  end

end
