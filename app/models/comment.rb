class Comment < ActiveRecord::Base
  include AdminView
  
  belongs_to :assignment
  belongs_to :user

  def student
    User.find(student_id)
  end

end
