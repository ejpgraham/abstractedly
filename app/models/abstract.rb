class Abstract < ApplicationRecord
  belongs_to :journal
  has_many :keywords
  has_many :custom_keywords

  def has_keyword?(keyword)
    keywords.where(body: keyword.body).any?
  end

  def user_is_subscribed_to_parent_journal?(current_user)
    journal.journal_feed.subscriptions.pluck(:user_id).include?(current_user.id)
  end

end
