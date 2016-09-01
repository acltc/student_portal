class RemoveCohortIdFromAssignment < ActiveRecord::Migration
  def change
    remove_column :assignments, :cohort_id, :integer
  end
end
