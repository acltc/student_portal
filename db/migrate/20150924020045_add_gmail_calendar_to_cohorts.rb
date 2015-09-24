class AddGmailCalendarToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :gmail_calendar, :string
  end
end
