class Api::V1::CommentsController < ApplicationController

  def index
    @comments = Comment.where(["assignment_id = ? and student_id = ?", params[:assignment_id], params[:student_id]]).order(:id)
    if current_user.instructor_or_administrator
      @all_comments_from_instructor = Comment.where(user_id: params[:admin_id]).order("assignment_id = #{params[:assignment_id]} DESC, id DESC")
      @admins = User.where(role_id: [1,2])
    end
  end

  def create
    @comment = Comment.new(text: params[:comment_text], assignment_id: params[:assignment_id], user_id: current_user.id, student_id: params[:student_id] )
    if @comment.user.instructor_or_administrator
      @comment.viewed_by_admin = true
      student = User.find(params[:student_id])
      PortalMailer.notify_student(student, @comment).deliver_now
    elsif @comment.user.student
      @comment.viewed_by_admin = false
    end
    @comment.save
  end

  def update
    @comment = Comment.find(params[:id])
    view_boolean = params[:update_viewed]
    comments = Comment.where("student_id = ? AND assignment_id = ?", @comment.student_id, @comment.assignment_id)
    if comments.update_all(viewed_by_admin: view_boolean)
      render json: {comment: comments.last}
    end
  end

end
