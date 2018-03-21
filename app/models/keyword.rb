class Keyword < ApplicationRecord
  belongs_to :abstract, dependent: :destroy

  def self.search(search)
    where("body ILIKE ?", "%#{search}%")
  end

  def self.subscribed_keywords(current_user)
    keywords = []
    current_user.subscriptions.each do |subscription|
      subscription.journal_feed.journals.each do |journal|
        journal.abstracts.each do |abstract|
          abstract.keywords.each {| keyword | keywords.push(keyword) }
        end
      end
    end
    keywords
  end
end
