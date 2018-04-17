class Scraper
  require 'adapter'
  attr_accessor :journal_feeds

  def initialize(optional_journal=nil)
    Feedjira::Feed.add_feed_class(Feedjira::Parser::Atypon)
    #New scraper instance
    @journal_feeds = []
    optional_journal ? @journal_feeds = [optional_journal] : @journal_feeds = JournalFeed.all
    fetch
  end

  def fetch
    @journal_feeds.each do |journal_feed|
      # begin
        p "Now scraping for #{journal_feed.title}"
        rss_feed = Feedjira::Feed.fetch_and_parse(journal_feed.url)
        next if rss_feed.entries.empty?

        journal = Journal.new({
          journal_feed: journal_feed,
          title: journal_feed.title,
          date: Date.today
          })

        # if journal_issue_does_not_already_exist?(journal_feed, journal)
          rss_feed.entries.each do |entry|
            if entry_satisfies_length_requirements(entry)
              #Check if a class exists for the journal feed. If not, build generic abstracts.
                Adapter.build_abstract(journal, entry)
            end
          end
          p "#{journal.title} complete!"
          journal.save! unless journal.abstracts.empty?
          p "#{journal.abstracts.count} abstracts created"
        # end
      # rescue => detail
      #   p detail
      #   next
      # end
    end
  end

  def journal_issue_does_not_already_exist?(journal_feed, journal)
    !(all_dates(journal_feed).include?(journal.date))
  end

  def all_dates(journal_feed)
    journal_feed.journals.map { |journal| journal.date }
  end

  def entry_does_not_contain_the_words?(string, entry)
    #Method added for clarity - necessary to filter out unusual
    #abstracts such as corrections to earlier abstracts.
    !(entry.summary.include?(string)) && !(entry.title.include?(string))
  end

  def entry_satisfies_length_requirements(entry)
    if entry.summary.present?
      entry_body = entry.summary
    elsif entry.content.present?
      entry_body = entry.content
    end
    entry_body = entry.abstract_body if entry.try(:abstract_body)

    if entry_body
      ActionView::Base.full_sanitizer.sanitize(entry_body.strip).length > 100
    else
      false
    end

    # TODO need method that checks if entry/summary is the longest attribute in the object, which
    # it generally should be.
  end

  def entry_does_not_already_exist?(journal_feed, entry)
    if entry.summary.nil?
      entry_body = entry.content
    else
      entry_body = entry.summary
    end

    entry_body = entry.abstract_body if entry.try(:abstract_body)

    return false if journal_feed.all_abstracts_associated_with_journal_feed
    .include?(Adapter.format_abstract_body(entry_body))
    true
  end

end
