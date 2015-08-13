class AddClassIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :class_group_id, :integer
  end
end
