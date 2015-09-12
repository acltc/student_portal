class Api::V1::SubmissionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @submissions = User.find(params[:student_id]).submissions.where(assignment_id: params[:id]).includes(:comments) || Submission.new(answer: "Nothing Submitted")
  end

  def create
    @submission = Submission.new(user_id:current_user.id, assignment_id: params[:id], answer:params[:submission_text], solution: params[:file])
    if @submission.save
      render json: '200'
    else
    end
  end
end
