module KeywordsHelper

  def keyword_bodies(abstract)
    abstract.keywords.map do |keyword|
      keyword.body
    end
  end

end
