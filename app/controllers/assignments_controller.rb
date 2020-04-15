class AssignmentsController < ApplicationController

  before_action :authenticate_admin_user!, only: :next_to_grade

  def index
    @student = current_user.student ? current_user : User.find(params[:student_id])
    @cohort = @student.cohort
    @assignments = @cohort.assignment_version.assignments.order(:assignment_order)
    @tab_index = params[:tab_index] || 1
  end

  def show
    @assignment = Assignment.find(params[:id])
    @student = current_user.student ? current_user : User.find(params[:student_id])
    @all_assignments_of_week = @student.cohort.assignment_version.assignments.where(week: @assignment.week).order(:assignment_order)
  end

  def new
    @assignment = Assignment.new
    assignment_version_id = params[:assignment_version_id]
    @assignment_version = AssignmentVersion.find(assignment_version_id)
  end

  def create
    @assignment = Assignment.new(assignment_params)

    if @assignment.save
      flash[:success] = "Exercise saved."
      redirect_to assignment_show_demo_path(@assignment)
    else
      flash[:danger] = "Exercise NOT saved. #{@assignment.errors.full_messages.join(', ')}"
      assignment_version_id = params[:assignment][:assignment_version_id]
      @assignment_version = AssignmentVersion.find(assignment_version_id)
      render :new
    end
  end

  def show_demo
    @assignment = Assignment.find(params[:id])
  end

  def edit
    @assignment = Assignment.find(params[:id])
    @assignment_version = @assignment.assignment_version
  end

  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
    else
      flash[:warning] = "Assignment failed to update"
    end
    redirect_to assignment_show_demo_path(@assignment)
  end

  def destroy
    @assignment = Assignment.find(params[:id]).delete
    if @assignment.delete
      flash[:success] = "Exercise deleted"
    else
      flash[:danger] = "Exercise NOT deleted"
    end
    redirect_to assignment_version_path(@assignment.assignment_version)
  end

  def next_to_grade
    if params[:cohort_id]
      cohort = Cohort.find(params[:cohort_id])
    else
      if params[:instructor_id]
        instructor_id = params[:instructor_id]
      else
        instructor_id = current_user.id
      end
      cohort = Cohort.where(instructor_id: instructor_id).last
    end

    next_submission = cohort.next_submission_to_assess

    redirect_to "/assignments/#{next_submission.assignment_id}?student_id=#{next_submission.user_id}"
  end

  private

  def assignment_params
    params.require(:assignment).permit(:week, :title, :question, :youtube_id, :attachment, :assignment_version_id)
  end

end
