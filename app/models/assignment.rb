class Assignment < ActiveRecord::Base

  has_many :submissions
  has_many :users, through: :submissions
  has_many :class_groups
end
