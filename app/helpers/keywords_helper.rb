module KeywordsHelper

  def unique_and_sorted_keywords(keywords)
    keywords.uniq {|keyword| keyword.body} .sort_by { |keyword| keyword.body } 
  end

end
