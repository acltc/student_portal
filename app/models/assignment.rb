class Assignment < ActiveRecord::Base
  has_many :submissions
  has_many :comments
  has_many :users, through: :submissions
  belongs_to :assignment_version
  has_many :grades

  validates :week, :question, :title, presence: true

  def self.download_ebook_pdf
    credentials = Aws::Credentials.new(ENV['S3_KEY'], ENV['S3_SECRET'])
    s3 = Aws::S3::Client.new(region:'us-west-2', credentials: credentials)
    Aws::S3::Object.new(
        key: 'learn-to-program_p4_0.pdf',
        bucket_name: ENV['S3_BUCKET_NAME'],
        client: s3
    ).presigned_url(:get, expires_in: 60 * 60)
  end

  def table_style
    id.even? ? "table-cell-even" : "table-cell-odd"
  end

  def short_title
    title.truncate(40)
  end
end
