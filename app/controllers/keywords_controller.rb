class KeywordsController < ApplicationController

  def show
    @keyword = Keyword.find(params[:id])
    @abstracts = Abstract.all
  end

  def index
    # @keywords = Keyword.all.group(:body)
    subscribed_keywords = Keyword.subscribed_keywords(current_user)
    keyword_count = Hash.new {[0, ""]}
    subscribed_keywords.each do |keyword| keyword_count[keyword.body] = [keyword_count[keyword.body][0]+=1,keyword]
    end
    @top_keywords = keyword_count.sort_by { |keyword, count| -count[0]}
    .first(10)
    # .map(&:first)
    # .flatten

    if params[:search]
      @keywords = Keyword.search(params[:search]).order("created_at DESC")
      flash[:notice] = "No keywords found." if @keywords.empty?
    else
    end
  end
end
