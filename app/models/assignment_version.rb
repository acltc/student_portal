class AssignmentVersion < ActiveRecord::Base
  has_many :cohorts
  has_many :assignments

  validates :description, presence: true
end
