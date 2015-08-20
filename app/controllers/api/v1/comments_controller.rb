class Api::V1::CommentsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @comment = Comment.new(text: params[:comment_text], submission_id: params[:submission_id], user_id: current_user.id )
    if @comment.save
      render json: 'ok'
    else
    end
  end
end
