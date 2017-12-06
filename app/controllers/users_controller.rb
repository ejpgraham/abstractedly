class UsersController < ApplicationController

  def update
    current_user.update(params.require(:user).permit!)
    flash[:notice] = "Subscriptions updated!"
    redirect_to root_path
  end

end
