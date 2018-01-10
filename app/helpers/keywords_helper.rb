module KeywordsHelper

  def keyword_bodies(abstract)
    abstract.keywords.map do |keyword|
      keyword.body
    end
  end

  def unique_keywords(keywords)
    unique = keywords.uniq { |keyword| keyword.body }
    unique.sort_by { |keyword| keyword.body }
  end

end
