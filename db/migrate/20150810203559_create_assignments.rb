class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :week
      t.text :question

      t.timestamps null: false
    end
  end
end
