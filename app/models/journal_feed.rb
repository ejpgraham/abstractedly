class JournalFeed < ApplicationRecord
  has_many :journals
  has_many :subscriptions
  has_many :users, through: :subscriptions

  def latest_journal
    journals.last
  end

  def sort_child_journals_by_date
    journals.sort_by { |journal| journal.date}.reverse
  end
end
