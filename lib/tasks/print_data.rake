namespace :print_data do
  desc "print out user data"
  task :answers, :student_id do |t, student_id|
    if @user = User.find_by(id: student_id)
      @user.submissions.each do |submission|
        
      end
    else
      "Student not found."
    end
  end

end
