class KeywordsController < ApplicationController

  def show
    @keyword = Keyword.find(params[:id])
    @abstracts = Abstract.all
  end

  def index
    @keywords = Keyword.all.group(:body)

    if params[:search]
      @keywords = Keyword.search(params[:search]).order("created_at DESC")
    else
      @keywords = Keyword.all.group(:body)
    end
  end
end
