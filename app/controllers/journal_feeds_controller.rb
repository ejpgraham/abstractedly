class JournalFeedsController < ApplicationController

  def index
    @journal_feeds = JournalFeed.all
    @custom_keyword = CustomKeyword.new
  end

  def new
  end

end
