class AddAssignmentVersionIdToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :assignment_version_id, :integer
  end
end
