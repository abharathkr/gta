class AdminMailer < ApplicationMailer

  def success_mail(email,studentcourses,student)
  	@studentcourses = studentcourses
  	@student = student
  	attachments["OILS_#{@student.unmid}."+@studentcourses.course1_content_type.split("/")[1]] = { :data => File.read(@studentcourses.course1.path), :mime_type => @studentcourses.course1_content_type }
  	attachments["EDPY_#{@student.unmid}."+@studentcourses.course2_content_type.split("/")[1]] = { :data => File.read(@studentcourses.course2.path), :mime_type => @studentcourses.course2_content_type }
  	attachments["Experience_#{@student.unmid}."+@studentcourses.teachexp_content_type.split("/")[1]] = { :data => File.read(@studentcourses.teachexp.path), :mime_type => @studentcourses.teachexp_content_type }
  	mail(to: email , subject: "Application Received from UNM ID:#{@student.unmid}")
  end

end
