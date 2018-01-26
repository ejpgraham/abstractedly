class RemoveSubscribedFromJournal < ActiveRecord::Migration[5.0]
  def change
    remove_column :journals, :subscribed, :boolean
  end
end
