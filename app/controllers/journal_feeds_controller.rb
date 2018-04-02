class JournalFeedsController < ApplicationController
  require 'rake'
  require 'Scraper'

  def show
    @journal_feed = JournalFeed.find(params[:id])
  end

  def index
    #Journal Feed view only displays subscribed feeds.
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

    if @journal_feed.save
      Scraper.fetch(@journal_feed.title)
      redirect_to @journal_feed
    else
      flash.now[:alert] = "This Feed could not be saved."
      render :new
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

end
