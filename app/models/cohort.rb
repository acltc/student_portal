class Cohort < ActiveRecord::Base
  has_many :users
  has_many :assignments
  belongs_to :instructor, foreign_key: 'instructor_id', class_name: "User"
  belongs_to :location
end
