class ChangeSubmissionIdToAssignmentId < ActiveRecord::Migration
  def change
    rename_column :comments, :submission_id, :assignment_id
  end
end
