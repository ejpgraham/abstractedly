class KeywordsController < ApplicationController

  def show
    @keyword = Keyword.find(params[:id])
    @abstracts = Abstract.all
  end

  def index
    # @keywords = Keyword.all.group(:body)
    all_keywords = Keyword.all
    keyword_count = Hash.new 0
    all_keywords.each {|keyword| keyword_count[keyword.body] += 1  }
    @top_keywords = keyword_count.sort_by  { |keyword, count| -count }
    .first(10)
    .map(&:first)
    .flatten

    if params[:search]
      @keywords = Keyword.search(params[:search]).order("created_at DESC")
      flash[:notice] = "No keywords found." if @keywords.empty?
    else
    end
  end
end
