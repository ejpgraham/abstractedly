class SubscriptionsController < ApplicationController

  def index
    @journal_feed = JournalFeed.new
  end

end
