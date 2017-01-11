class AssignmentVersionsController < ApplicationController
  before_action :authenticate_admin_user!
  
  def index
    @assignment_versions = AssignmentVersion.all
  end

  def show
    @assignment_version = AssignmentVersion.find(params[:id])
  end

  def create
    new_assignment_version = AssignmentVersion.new(description: params[:description])

    if params[:assignment_version][:id].present? && new_assignment_version.save
      assignment_version_to_copy = AssignmentVersion.find(params[:assignment_version][:id])

      assignment_version_to_copy.assignments.order(:assignment_order).each_with_index do |assignment, index|
        assignment_order = index + 1
        new_assignment = assignment.dup
        new_assignment.assignment_version_id = new_assignment_version.id
        new_assignment.assignment_order = assignment_order
        new_assignment.save
      end
      redirect_to assignment_version_path(new_assignment_version)
    else
      version_selected = params[:assignment_version][:id].blank? ? "Please choose an assignment version" : nil
      errors = new_assignment_version.errors.full_messages << version_selected
      flash[:danger] = "Assignment Version not created. #{errors.join(", ")}"
      redirect_to assignment_versions_path
    end
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
