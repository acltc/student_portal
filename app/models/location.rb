class Location < ActiveRecord::Base
  has_many :cohorts

  validates :name, presence: true
end
