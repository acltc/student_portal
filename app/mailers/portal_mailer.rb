class PortalMailer < ApplicationMailer

  def welcome_student(student)
    @student = student
    mail(from: "no-reply@anyonecanlearntocode.com", to: @student.email, subject: "Welcome to the Anyone Can Learn To Code Student Portal!")
  end

  def notify_student(student, comment)
    @student = student
    @comment = comment
    mail(from: "no-reply@anyonecanlearntocode.com", to: @student.email, subject: 'You have a new message from your instructor')
  end

  def welcome_admin(user)
    @user = user
    mail(from: "no-reply@anyonecanlearntocode.com", to: @user.email, subject: "Welcome to the Anyone Can Learn To Code Student Portal #{@user.role.category.upcase}!")
  end
end
