class Comment < ActiveRecord::Base
  include AdminView
  
  belongs_to :assignment
  belongs_to :user
end
