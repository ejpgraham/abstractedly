class Abstract < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_body, :against => :body
    # :if => :user_is_subscribed_to_parent_journal?

  belongs_to :journal, dependent: :destroy
  has_many :keywords
  has_many :custom_keywords

  def has_keyword?(keyword)
    keywords.where(body: keyword.body).any?
  end

  def has_custom_keyword?(keyword)
    custom_keywords.where(body: keyword.body).any?
  end

  def user_is_subscribed_to_parent_journal?(current_user)
    journal.journal_feed.subscriptions.pluck(:user_id).include?(current_user.id)
  end

end
