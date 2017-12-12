class UsersController < ApplicationController

  def update
    current_user.update(user_params)
    flash[:notice] = "Subscriptions updated!"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(journal_feed_ids: [])
  end
end
