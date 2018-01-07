class Scraper

  def self.fetch
    journal_feeds = JournalFeed.all
    journal_feeds.each do |journal_feed|
      rss_feed = Feedjira::Feed.fetch_and_parse(journal_feed.url)
      journal = Journal.new({journal_feed: journal_feed, title: journal_feed.title, date: rss_feed.entries.first.published })
      # if journal_issue_does_not_already_exist?(journal_feed, journal)
        rss_feed.entries.each do |entry|
          if entry.summary.present? && entry_does_not_contain_the_words?("Correction to:", entry.summary)
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
      # end
    end
  end

  def self.journal_issue_does_not_already_exist?(journal_feed, journal)
    !(all_dates(journal_feed).include?(journal.date))
  end

  def self.all_dates(journal_feed)
    journal_feed.journals.map { |journal| journal.date }
  end

  def self.entry_does_not_contain_the_words?(string, entry)
    #Method added for clarity - necessary to filter out unusual
    #abstracts such as corrections to earlier abstracts.
    !(entry.include?(string))
  end


end
