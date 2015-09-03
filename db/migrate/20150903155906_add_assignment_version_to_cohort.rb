class AddAssignmentVersionToCohort < ActiveRecord::Migration
  def change
    add_column :cohorts, :assignment_version_id, :integer
  end
end
