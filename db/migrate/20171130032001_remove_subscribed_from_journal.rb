class RemoveSubscribedFromJournal < ActiveRecord::Migration
  def change
    remove_column :journals, :subscribed, :boolean
  end
end
