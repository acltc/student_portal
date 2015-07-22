class ChangePagesToText < ActiveRecord::Migration
  def change
    change_column :pages, :welcome_message,  :text
    change_column :pages, :capstone,  :text
    change_column :pages, :blog,  :text
  end
end
