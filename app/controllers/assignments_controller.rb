class AssignmentsController < ApplicationController

  def index
    @assignments = Assignment.all
    @class_group = current_user.class_group
  end

  def show
    
  end

end
