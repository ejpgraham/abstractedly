class JournalFeedsController < ApplicationController
  require 'scraper'

  def show
    @journal_feed = JournalFeed.find(params[:id])
  end

  def index
    #Journal Feeds view only displays subscribed feeds.
    @journal_feeds = JournalFeed.joins(:subscriptions)
    .where('subscriptions.user_id' => current_user.id)
    .includes({:journals => {:abstracts => :keywords}})
    .sort_by {|feed| feed.latest_journal.date}.reverse
    @custom_keyword = CustomKeyword.new
  end

  def new
    @journal_feed = JournalFeed.new
  end

  def create
    @journal_feed = JournalFeed.new(journal_feed_params)

    if journal_feed_url_is_valid?(@journal_feed)
      @journal_feed.save
      redirect_to @journal_feed
    else
      render 'subscriptions/index'
    end

  end

  def edit

  end

  def update

  end

  def delete
    @journal_feed = JournalFeed.find(params[:id])
    @journal_feed.destroy if @journal_feed.journals.empty?
  end

  private

  def journal_feed_params
    params.require(:journal_feed).permit(:title, :url)
  end

  def journal_feed_url_is_valid?(journal_feed)
    #TODO check if this can be replaced by a custom validation at model level
    begin
      Feedjira::Feed.fetch_and_parse(journal_feed.url)
      Scraper.new(@journal_feed)
      if !@journal_feed.journals.empty?
        true
       else
        flash.now[:alert] = 'Abstractedly thinks the abstracts in this feed are too short to save, so it did not.'
        false
      end
    rescue
      flash.now[:alert] = "Abstractedly could not access this RSS feed. Check your URL and try again."
      false
    end
  end

end
