class UsersController < ApplicationController

  def update
    #this method updates subscriptions
    current_user.update(user_params)
    flash[:notice] = "Subscriptions updated!"
    redirect_to journal_feeds_path
  end

  private

  def user_params
    params.require(:user).permit(journal_feed_ids: [])
  end
end
