class PortalMailer < ApplicationMailer

  def welcome_student(student)
    @student = student
    mail(from: "no-reply@anyonecanlearntocode.com", to: @student.email, subject: 'Welcome to the Anyone Can Learn To Code Student Portal!', cc: "glenn@anyonecanlearntocode.com", bcc: "mark@anyonecanlearntocode.com")
  end

  def notify_student(student)
    @student = student
    mail(from: "no-reply@anyonecanlearntocode.com", to: @student.email, subject: 'You have a new message from your instructor', bcc: "mark@anyonecanlearntocode.com")
  end
end
