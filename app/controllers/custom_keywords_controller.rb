class CustomKeywordsController < ApplicationController

  def show
    @custom_keyword = CustomKeyword.find(params[:id])
    @abstracts = Abstract.all #TODO this should be a database query WHERE abstract has @custom_keyword
    #need to make keyword show and custom_keyword show display articles when keywords are only diff
    #by capitalization
  end

  def new
    @custom_keyword = CustomKeyword.new
  end

  def create
    @custom_keyword = CustomKeyword.new(custom_keyword_params)
    @custom_keyword.user = current_user

    if @custom_keyword.save
      @abstract = Abstract.find(custom_keyword_params[:abstract_id])
      respond_to do |format|
        format.js
      end
    else
    end
  end



  private

  def custom_keyword_params
    params.require(:custom_keyword).permit(:body, :abstract_id)
  end
end
