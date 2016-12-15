class AssignmentVersionsController < ApplicationController
  
  def index
    @assignment_versions = AssignmentVersion.all
  end

  def show
    @assignment_version = AssignmentVersion.find(params[:id])
  end

  def update # this needs to be updated to factor in week too
    @assignment_orders = params[:assignment_orders]
    @assignment_orders.each do |assignment_id, assignment_order|
      Assignment.find(assignment_id).update(assignment_order: assignment_order)
    end
    redirect_to assignment_version_path(params[:assignment_version_id])
  end


end
