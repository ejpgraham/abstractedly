class JournalFeed < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true

  has_many :journals
  has_many :subscriptions
  has_many :users, through: :subscriptions

  def latest_journal
    journals.last
  end

  def sort_child_journals_by_date
    journals.sort_by { |journal| journal.date}.reverse
  end

  def all_abstracts_associated_with_journal_feed
    abstracts = []
    journals.each do |journal|
      journal.abstracts.each do |abstract|
        abstracts.push(abstract)
      end
    end
  end
  
end
