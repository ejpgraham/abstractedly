class JournalFeed < ApplicationRecord
  has_many :journals
  has_many :subscriptions
  has_many :users, through: :subscriptions


end
