class JournalFeedsController < ApplicationController

  def index
    @journal_feeds = JournalFeed.all
  end

end
