class AssignmentsController < ApplicationController

  def index
    if current_user.role_id == 3 #student
      @student = current_user
      @cohort = current_user.cohort
      @assignments = current_user.cohort.assignments
    else #instructor or admin
      @student = User.find(params[:student_id])
      @cohort = @student.cohort
      @assignments = @cohort.assignment_version.assignments
    end
  end

  def show
    @assignment = Assignment.find(params[:id])
    @student = User.find(params[:student_id])
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
    params.require(:assignment).permit(:title, :question)
  end

end
