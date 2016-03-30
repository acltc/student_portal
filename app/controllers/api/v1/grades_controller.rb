class Api::V1::GradesController < ApplicationController
  def check_current
    if @grade = Grade.find_by(user_id: params[:student_id], assignment_id: params[:assignment_id])
      render 'show.json.jbuilder'
    else
      render json: {message: "no grade yet"}
    end
  end

  def create

    @grade = Grade.find_or_create_by(user_id: params[:student_id], assignment_id: params[:assignment_id])
    @grade.update(letter: params[:letter], week: Assignment.find(params[:assignment_id]).week)

    render 'show.json.jbuilder'
  end
end