class Scraper

  def self.fetch
    journal_feeds = JournalFeed.all
    journal_feeds.each do |journal_feed|
      feed = Feedjira::Feed.fetch_and_parse(journal_feed.url)
      journal = Journal.new({journal_feed: journal_feed, title: journal_feed.title, date: feed.entries.first.published })
      unless Scraper.dates(journal_feed).include?(journal.date)
        feed.entries.each do |entry|
          unless entry.summary.blank? || entry.summary.include?("Correction to:")
            case journal_feed.title
            when "European Journal of Nuclear Medicine and Imaging"
              Adapter.european_journal_adapter(journal, entry)
            when "Journal of Nuclear Medicine"
              Adapter.journal_of_nuclear_medicine_adapter(journal, entry)
            when "NeuroImage"
              Adapter.neuro_image_adapter(journal, entry)
            end
          end
        end
        journal.save!
      end
    end
  end

  def self.dates(journal_feed)
    dates = []
    journal_feed.journals.each do |journal|
      dates.push(journal.date)
    end
    dates
  end

end
# create_table "abstracts", force: :cascade do |t|
#   t.text     "title"
#   t.text     "authors"
#   t.text     "body"
#   t.string   "images"
#   t.string   "url"
#   t.boolean  "visible"
#   t.integer  "journal_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

# create_table "journals", force: :cascade do |t|
#   t.string   "title"
#   t.string   "url"
#   t.date     "date"
#   t.integer  "volume"
#   t.integer  "issue_number"
#   t.datetime "created_at",      null: false
#   t.datetime "updated_at",      null: false
#   t.integer  "journal_feed_id"
# end
