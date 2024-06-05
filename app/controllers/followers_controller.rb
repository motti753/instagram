class FollowersController < ApplicationController
  def index
    @followers = Relationship.where(following_id: params[:account_id])
    @avatar = []
    @followers_list = @followers.pluck(:follower_id)
    # followerが0人の場合、nullの配列を戻り値とする
    if @followers.exists?
      @account = User.where(id: @followers_list).pluck(:account)
      @followers.each do |follower|
        @profile = Profile.find(follower.follower_id)
        @avatar.push(url_for(@profile.avatar_image))
      end
    else
      @account = []
    end
  end
end