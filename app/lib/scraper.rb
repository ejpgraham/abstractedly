class Scraper
  require 'Adapter'

  def self.fetch(optional_journal=nil)
    if optional_journal
      journal_feeds = [optional_journal]
    else
    journal_feeds = JournalFeed.all
    end
    Feedjira::Feed.add_feed_class(Feedjira::Parser::Atypon)
    journal_feeds.each do |journal_feed|
      begin
        p "Now scraping for #{journal_feed.title}"
        rss_feed = Feedjira::Feed.fetch_and_parse(journal_feed.url)
        next if rss_feed.entries.empty?
        rss_feed.entries.first.published ? date = rss_feed.entries.first.published : date = Date.today
        journal = Journal.new({
          journal_feed: journal_feed,
          title: journal_feed.title,
          date: date
          })
          # binding.pry if journal_feed.url == "https://medium.com/feed/@eLife"
        if journal_issue_does_not_already_exist?(journal_feed, journal)
          rss_feed.entries.each do |entry|
            if entry_satisfies_length_requirements(entry) && entry_does_not_already_exist?(journal_feed, entry)
              #Check if a class exists for the journal feed. If not, build generic abstracts.
              if Object.const_defined?(journal_feed.title.titleize.gsub(" ", "").gsub(/[^a-z0-9\s]/i, ''))
                journal_feed.title.titleize.gsub(" ", "").constantize.build_abstract(journal, entry)
              else
                Adapter.build_generic_abstract(journal, entry)
              end
            end
          end
          p "#{journal.title} complete!"
          journal.save! unless journal.abstracts.empty?
          p "#{journal.abstracts.count} abstracts created"
        end
      rescue => detail
        p detail
        next
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
      ActionView::Base.full_sanitizer.sanitize(entry.summary.strip).length > 100
    elsif entry.content.present?
      ActionView::Base.full_sanitizer.sanitize(entry.content.strip).length > 100
    end
    # TODO need method that checks if entry/summary is the longest attribute in the object, which
    # it generally should be.
  end

  def self.entry_does_not_already_exist?(journal_feed, entry)
    if entry.summary.nil?
      entry_body = entry.content
    else
      entry_body = entry.summary
    end
    return false if journal_feed.all_abstracts_associated_with_journal_feed
    .include?(Adapter.format_abstract_body(entry_body))
    true
  end

end
