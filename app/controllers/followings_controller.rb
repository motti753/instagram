class FollowingsController < ApplicationController
  def index
    @followings = Relationship.where(follower_id: params[:account_id])
    @avatar = []
    @following_list = @followings.pluck(:following_id)
    # followerが0人の場合、nullの配列を戻り値とする
    if @followings.exists?
      @account = User.where(id: @following_list).pluck(:account)
      @followings.each do |following|
        @profile = Profile.find(following.following_id)
        if @profile.avatar&.attached?
          @avatar.push(url_for(@profile.avatar_image))
        else
          @avatar.push(url_for('/assets/default-avatar-12a3f7379a4333007fa16fb67297f8a31c88580ccdaf11eb0be7323847c5641a.png'))
        end
      end
    else
      @account = []
    end

    @avatar.to_json
  end
end