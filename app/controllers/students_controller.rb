class StudentsController < ApplicationController

  def new
  end

  def create
    student_emails = params[:student_emails].split(",")
    successful_creates = []
    errors = []
    student_emails.each do |student_email|
      new_student = User.new(cohort_id: params[:cohort_id], email: student_email, password: "changeme", role_id: 3)
      if new_student.save
        successful_creates << new_student.email
      else
        errors << "For #{new_student.email}, #{new_student.errors.full_messages.join(",")}"
      end
    end
    flash[:success] = "Account(s) for #{successful_creates.join(",")} created successfully" if successful_creates.any?
    flash[:danger] = errors.join("; ").html_safe if errors.any?
    redirect_to cohorts_path
  end
end
