class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :journal_feed

  validates_presence_of :user
  validates_presence_of :journal_feed

  accepts_nested_attributes_for :journal_feed
end
