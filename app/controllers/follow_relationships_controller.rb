class FollowRelationshipsController < ApplicationController

	def create
    @user =User.find(params[:user_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html {redirect_to request.referer }
      format.js
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    respond_to do |format|
      format.html {redirect_to request.referer }
      format.js
    end
  end

end
