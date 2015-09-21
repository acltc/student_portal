class Assignment < ActiveRecord::Base
  has_many :submissions
  has_many :comments
  has_many :users, through: :submissions
  belongs_to :assignment_version

  def self.download_ebook_pdf
    credentials = Aws::Credentials.new(ENV['S3_KEY'], ENV['S3_SECRET'])
    s3 = Aws::S3::Client.new(region:'us-west-2', credentials: credentials)
    Aws::S3::Object.new(
        key: 'learn-to-program_p4_0.pdf',
        bucket_name: ENV['S3_BUCKET_NAME'],
        client: s3
    ).presigned_url(:get, expires_in: 60 * 60)
  end

  def get_css_class_resources(viewed_assignment, current_user, student)
    css_class = ""
    css_class << "current-assignment" if id == viewed_assignment.id
    if current_user.instructor_or_administrator && student.submissions.where(assignment_id: id).any?
      admin_highlight = student.submissions.where(assignment_id: id).last.viewed_by_admin ? " viewed-key" : " un-viewed-key"
      css_class << admin_highlight
    end
    return css_class
  end

end
