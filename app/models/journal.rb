class Journal < ActiveRecord::Base
  has_many :abstracts
  belongs_to :journal_feed
end
