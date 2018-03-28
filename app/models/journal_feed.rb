class JournalFeed < ApplicationRecord
  has_many :journals
  has_many :subscriptions
  has_many :users, through: :subscriptions

  def latest_journal
    journals.last 
  end
end
