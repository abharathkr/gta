class AdminMailer < ApplicationMailer

  def success_mail(email,path)
  	print path
  	attachments['file'] = File.read(path.sub! '//','/')
  	mail(to: email , subject: "Application Received")
  end

end
