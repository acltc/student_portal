class PortalMailer < ApplicationMailer

  def notify_student(student)
    @student = student
    mail(from: "info@anyonecanlearntocode.com", to: @student.email, subject: 'You have a new message from your instructor', bcc: "mark@anyonecanlearntocode.com")
  end

end
