class KeywordsController < ApplicationController

  def show
    @keyword = Keyword.find(params[:id])
  end

  def index
    subscribed_keywords = Keyword.subscribed_keywords(current_user)
    keyword_count = Hash.new {[0, ""]}
    subscribed_keywords.each do |keyword| keyword_count[keyword.body] = [keyword_count[keyword.body][0]+=1,keyword]
    end
    @top_keywords = keyword_count.sort_by { |keyword, count| -count[0]}
    .first(10)

    if params[:search]
      all_keywords_matching_search = Keyword.search(params[:search]).order("body DESC")
      subscribed_keywords = []
      @keywords = all_keywords_matching_search.select do |keyword|
        keyword.abstract.user_is_subscribed_to_parent_journal?(current_user)
      end
      flash[:notice] = "No keywords found." if @keywords.empty?
    else
    end
  end
end
