module KeywordsHelper

  def keyword_bodies(abstract)
    abstract.keywords.pluck(:body)
  end
end
