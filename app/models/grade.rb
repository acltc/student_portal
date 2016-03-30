class Grade < ActiveRecord::Base

  belongs_to :user
  belongs_to :assignment

  validates :user_id, uniqueness: { scope: :assignment_id }

  def table_style
    if letter == "R/v"
      "grade-table-review"
    elsif letter == "N/A"
      "grade-table-na"
    elsif letter == "F" || letter == "A+"
      "grade-table-notice"
    end      
  end
end

