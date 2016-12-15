class AssignmentVersionsController < ApplicationController
  
  def index
    @assignment_versions = AssignmentVersion.all
  end

  def show
    @assignment_version = AssignmentVersion.find(params[:id])
  end

  def update
    @assignments = params[:assignments]
    @assignments.each do |assignment|
      Assignment.find(assignment[:id]).update(week: assignment[:week], assignment_order: assignment[:order])
    end
    flash[:success] = "Week & Order of exercises updated successfully"
    redirect_to assignment_version_path(params[:assignment_version_id])
  end

end
