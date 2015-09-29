class Api::V1::SubmissionsController < ApplicationController

  def index
    @submissions = User.find(params[:student_id]).submissions.where(assignment_id: params[:assignment_id]) || Submission.new(answer: "Nothing Submitted")
  end

  def create
    @submission = Submission.new(user_id: params[:student_id], assignment_id: params[:assignment_id], answer: params[:submission_text], solution: params[:file], viewed_by_admin: false)
    if @submission.save
    else
    end
  end

  def download_file
    credentials = Aws::Credentials.new(ENV['S3_KEY'], ENV['S3_SECRET'])
    s3 = Aws::S3::Client.new(region:'us-west-2', credentials: credentials)
    @url = Aws::S3::Object.new(
      key: "uploads/submission/solution/#{params[:id]}/#{params[:file_name]}",
      bucket_name: ENV['S3_BUCKET_NAME'],
      client: s3
    ).presigned_url(:get, expires_in: 60 * 60)
    render json: {url: @url}
  end

  def update
    @submission = Submission.find(params[:id])
    view_boolean = params[:update_viewed]
    submissions_of_assignment = Submission.where("user_id = ? AND assignment_id = ?", @submission.user_id, @submission.assignment_id)
    if submissions_of_assignment.update_all(viewed_by_admin: view_boolean)
      render json: {submission: submissions_of_assignment.last}
    end
  end

  def destroy
    Submission.find(params[:id]).destroy
    render json: "204"
  end

end
