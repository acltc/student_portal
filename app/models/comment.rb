class Comment < ActiveRecord::Base
  include AdminView
  
  belongs_to :assignment
  belongs_to :user

  def student
    begin
      User.find(student_id)
    rescue ActiveRecord::RecordNotFound => e
      User.new(first_name: "", last_name: "UNKNOWN")
    end  
  end

end
