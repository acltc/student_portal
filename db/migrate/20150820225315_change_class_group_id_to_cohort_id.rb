class ChangeClassGroupIdToCohortId < ActiveRecord::Migration
  def change
    rename_column :users, :class_group_id, :cohort_id
  end
end
