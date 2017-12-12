class AddJournalFeedRefToJournal < ActiveRecord::Migration
  def change
    add_reference :journals, :journal_feed, foreign_key: true
  end
end
