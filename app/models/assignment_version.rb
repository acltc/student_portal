class AssignmentVersion < ActiveRecord::Base
  has_many :cohorts
  has_many :assignments, dependent: :destroy

  validates :description, presence: true
end
