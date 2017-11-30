class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :journal_feed
end
