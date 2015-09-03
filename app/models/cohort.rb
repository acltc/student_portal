class Cohort < ActiveRecord::Base
  has_many :users
  belongs_to :assignment_version
  belongs_to :instructor, foreign_key: 'instructor_id', class_name: "User"
  belongs_to :location
end
