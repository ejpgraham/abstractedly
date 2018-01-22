class Journal < ApplicationRecord
  has_many :abstracts
  belongs_to :journal_feed
end
