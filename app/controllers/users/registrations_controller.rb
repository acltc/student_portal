class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_admin_user!, only: [:new, :create]
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  def index
    @users = User.order(:last_name)
  end

  def new_admin
    @user = User.new
  end

  def create_admin
    @user = User.new(email: params[:email], password: "changeme", first_name: params[:first_name], last_name: params[:last_name], role_id: params[:role][:id])
    if @user.save
      PortalMailer.welcome_admin(@user).deliver_now
      flash[:success] = "Instructor/Admin Created"
      redirect_to "/users/registrations"
    else
      render :new_admin
    end
  end

  def new_batch
    @cohort = Cohort.find(params[:cohort_id])
  end

  def create_batch
    students_details = params[:student_details].split("\r\n").reject(&:empty?)
    successful_creates = []
    errors = []
    students_details.each do |student_detail_string|
      student_details = student_detail_string.split(",")
      first_name = student_details[0].strip
      last_name = student_details[1].strip
      email = student_details[2].strip
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

  def edit_user
    @user = User.find(params[:id])
    @cohort_id = @user.cohort.id if @user.cohort
  end

  def update_user
    @user = User.find(params[:id])
    current_cohort_id = @user.cohort_id
    if @user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], role_id: params[:role][:id], cohort_id: params[:cohort][:id])
      if current_cohort_id != @user.cohort_id
        @student.submissions.each do |submission|
          submission.answer = "[#{@student.email}] #{submission.answer}" if submission.answer
          submission.user_id = nil
          submission.save
        end
      end
      flash[:success] = "Account successfully updated"
      redirect_to cohorts_path
    else
      render :edit
    end
  end

  def destroy
    @student = User.find(params[:id])
    @user.destroy
    flash[:success] = "Student Deleted"
    redirect_to cohorts_path
  end
end
