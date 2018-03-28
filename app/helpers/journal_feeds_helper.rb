module JournalFeedsHelper
  def journal_title_and_date(journal_feed)
    journal_feed.title + " Latest issue: " + journal_feed.journals.last.date.to_s
  end

  def latest_journal_in_journal_feed(journal_feed)
    journal_feed.journals.sort_by()
  end
end
