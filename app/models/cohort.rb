class Cohort < ActiveRecord::Base
  has_many :users
  belongs_to :assignment_version
  belongs_to :instructor, foreign_key: 'instructor_id', class_name: "User"
  belongs_to :location
  has_many :grades, through: :users
  has_many :submissions, through: :users

  validates :start_date, presence: true
  validates_associated :location, :assignment_version

  def all_attributes
    "Start Date: #{start_date} Instructor: #{instructor.full_name} Location: #{location.name}"
  end

  def grades_for_table
      current_grades_ungrouped = self.grades

      Hash[current_grades_ungrouped.group_by(&:week).map { |week_num, week_grades| 
        [week_num, Hash[week_grades.group_by(&:user_id).map { |user_num, user_grades|
          [user_num, Hash[user_grades.map { |grade_assessed| 
            [grade_assessed.assignment_id, grade_assessed]
            }]]
          }]]
        }.sort] 
  end

  def submissions_for_table
      current_submissions_ungrouped = self.submissions

      submissions = Hash[current_submissions_ungrouped.group_by(&:assignment_id).map { |assignment_num, assignment_submissions|
        [assignment_num, Hash[assignment_submissions.map {|submission|
          [submission.user_id, submission]
          }]]
        }]

      submissions.default = {}
      submissions
  end

  def students
    users.where(role_id: 3)
  end

  def student_names_for_table
    Hash[students.map { |student| [student.id, "#{student.first_name} #{student.last_name[0]}"]}]
  end

  def next_submission_to_assess
    
    submissions_holder = self.submissions.order(:assignment_id,:user_id).to_a
    grades_holder = self.grades

    submissions_holder.delete_if do |submission|
      grades_holder.any? do |grade|
        submission.assignment_id == grade.assignment_id && submission.user_id == grade.user_id
      end
    end

    submissions_holder.first
  end
end
