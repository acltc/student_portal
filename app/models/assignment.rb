class Assignment < ActiveRecord::Base

  has_many :submissions
  has_many :users, through: :submissions
  belongs_to :assignment_version
end
