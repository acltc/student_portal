class Grades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string  :letter
      t.integer :user_id
      t.integer :assignment_id

      t.timestamps null: false
    end
  end
end
