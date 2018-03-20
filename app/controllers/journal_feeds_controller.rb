class JournalFeedsController < ApplicationController

  def index
    @journal_feeds = JournalFeed.all
    @custom_keyword = CustomKeyword.new
  end

  def new
    @journal_feed = JournalFeed.new
  end

  def create
    @journal_feed = JournalFeed.new(journal_feeds_params)
  end

  def edit

  end

  def update

  end

  private

  def journal_feeds_params
    params.require(:journal_feed).permit(:title, :url)
  end

end
