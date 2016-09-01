class CreateClassGroups < ActiveRecord::Migration
  def change
    create_table :class_groups do |t|
      t.date :week_one_due_date
      t.date :week_two_due_date
      t.date :week_three_due_date
      t.integer :instructor_id

      t.timestamps null: false
    end
  end
end
