class KeywordsController < ApplicationController

  def show
    @keyword = Keyword.find(params[:id])
    @abstracts = Abstract.all
  end

  def index
    @keywords = Keyword.all.group(:body)
  end
end
