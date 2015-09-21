class AssignmentsController < ApplicationController

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

  def edit
    @assignment = Assignment.find(params[:id])
    @student = User.find(params[:student_id])
  end

  def update
    @assignment = Assignment.find(params[:id])
    @student = User.find(params[:assignment][:student_id])
    if @assignment.update(assignment_params)
      flash[:success] = "Assignment exercise updated."
      redirect_to "/assignments/#{@assignment.id}?student_id=#{@student.id}"
    else
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:title, :question, :youtube_id, :attachment)
  end

end
