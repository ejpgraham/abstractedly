class JournalFeedsController < ApplicationController

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
