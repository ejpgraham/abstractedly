class Abstract < ActiveRecord::Base
  belongs_to :journal
  has_many :keywords
  has_many :custom_keywords

  def has_keyword?(keyword)
    keywords.where(body: keyword.body).any?
  end

end
