class AssignmentsController < ApplicationController

  def index
    @assignments = current_user.cohort.assignments
    @cohort = current_user.cohort
  end

  def show
    
  end

end
