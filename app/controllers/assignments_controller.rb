class AssignmentsController < ApplicationController

  before_action :authenticate_admin_user!, only: :next_to_grade

  def index
    @student = current_user.student ? current_user : User.find(params[:student_id])
    @cohort = @student.cohort
    @assignments = @cohort.assignment_version.assignments.order(:id)
    @tab_index = params[:tab_index] || 1
  end

  def show
    @assignment = Assignment.find(params[:id])
    @student = User.find(params[:student_id])
    @all_assignments_of_week = @student.cohort.assignment_version.assignments.where(week: @assignment.week).order(:id)
  end

  def show_demo
    @assignment = Assignment.find(params[:id])
  end

  def edit
    @assignment = Assignment.find(params[:id])
  end

  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
      redirect_to assignment_show_demo_path(@assignment)
    else
      flash[:warning] = "Assignment failed to update"
    end
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
    params.require(:assignment).permit(:title, :question, :youtube_id, :attachment)
  end

end
