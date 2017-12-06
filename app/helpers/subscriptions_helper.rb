module SubscriptionsHelper

  def subscription_user_ids(journal_feed)
    subscription_ids = journal_feed.subscriptions.map {|subscription| subscription.user_id}
  end

end
