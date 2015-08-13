class ClassGroup < ActiveRecord::Base
  has_many :users
  belongs_to :instructor, foreign_key: 'instructor_id', class_name: "User"
end
