module JournalFeedsHelper
  def journal_title_and_date(journal)
    journal.title + ": " + journal.date.to_s
  end
end
