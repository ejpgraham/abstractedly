class Scraper

  def self.fetch
    journal_feeds = JournalFeed.all
    journal_feeds.each do |journal_feed|
      rss_feed = Feedjira::Feed.fetch_and_parse(journal_feed.url)
      journal = Journal.new({
        journal_feed: journal_feed,
        title: journal_feed.title,
        date: rss_feed.entries.first.published
        })
      if journal_issue_does_not_already_exist?(journal_feed, journal)
        rss_feed.entries.each do |entry|
          if entry_satisfies_length_requirements(entry)
              journal_feed.title.titleize.gsub(" ", "").constantize.build_abstract(journal, entry)
          end
        end
        journal.save!
        p "#{journal.title} complete!"
      end
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
    !(entry.summary.include?(string)) && !(entry.title.include?(string))
  end

  def self.entry_satisfies_length_requirements(entry)
    if entry.summary.present?
      ActionView::Base.full_sanitizer.sanitize(entry.summary.strip).length > 150
    end
  end


end
