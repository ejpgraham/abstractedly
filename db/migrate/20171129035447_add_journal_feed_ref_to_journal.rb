class AddJournalFeedRefToJournal < ActiveRecord::Migration[5.0]
  def change
    add_reference :journals, :journal_feed, foreign_key: true
  end
end
