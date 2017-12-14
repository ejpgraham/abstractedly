class JournalFeedsController < ApplicationController
  include ScrapeHelper

  def index
    @journal_feeds = JournalFeed.all
    @site = scrape_site
  end

  def new
  end

end
