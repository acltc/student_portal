class Submission < ActiveRecord::Base
  include AdminView
  
  mount_uploader :solution, SolutionUploader
  belongs_to :assignment
  belongs_to :user
  has_many :comments
end
