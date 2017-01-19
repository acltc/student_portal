# Example usage:
# rake print_data:answers[3]
# ...prints out answers for student with id of 3
namespace :print_data do
  desc "print out user data"
  task :answers, [:student_id] => :environment do |t, options|
    student_id = options[:student_id]
    if @user = User.find_by(id: student_id)
      @user.submissions.each do |submission|
        if submission.answer
          puts submission.assignment.title
          puts submission.created_at
          puts submission.answer
          puts
          puts
        end
      end
    else
      p "Student not found."
      p student_id
    end
  end

end
