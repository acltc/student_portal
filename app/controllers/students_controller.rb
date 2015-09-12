class StudentsController < ApplicationController
  before_action :authenticate_admin_user!

  def new
    @cohort = Cohort.find(params[:cohort_id])
  end

  def create
    students_details = params[:student_details].split("\r\n").reject(&:empty?)
    successful_creates = []
    errors = []
    students_details.each do |student_detail_string|
      student_details = student_detail_string.split(",")
      first_name = student_details[0]
      last_name = student_details[1]
      email = student_details[2]
      new_student = User.new(cohort_id: params[:cohort_id], email: email, first_name: first_name, last_name: last_name, password: "changeme", role_id: 3)
      if new_student.save
        PortalMailer.welcome_student(new_student).deliver_now
        successful_creates << "<span style='color:green'>Account created successfully for #{new_student.full_name} and welcome email sent to #{new_student.email} </span>"
      else
        errors << "<span style='color:red'>For #{new_student.full_name}, #{new_student.errors.full_messages.join(", ")}</span>"
      end
    end
    message = ""
    message << successful_creates.join("<br/>") if successful_creates.any?
    message << "<br/><br/>" if successful_creates.any? && errors.any?
    message << errors.join("<br/>") if errors.any?
    flash[:warning] = message
    redirect_to cohorts_path
  end

  def edit
    @student = User.find(params[:id])
  end

  def update
    @student = User.find(params[:id])
    if @student.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
      flash[:success] = "Account successfully updated"
      redirect_to cohorts_path
    else
      render :edit
    end
  end

  def destroy
    @student = User.find(params[:id])
    @student.destroy
    redirect_to cohorts_path
  end




end
