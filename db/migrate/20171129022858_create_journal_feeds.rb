class CreateJournalFeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :journal_feeds do |t|
      t.string :title
      t.string :url
      t.string :cover_image_url
    end
  end
end
