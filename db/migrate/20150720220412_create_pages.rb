class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :welcome_message
      t.string :capstone
      t.string :blog

      t.timestamps null: false
    end
  end
end
