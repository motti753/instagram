class Apps::ProfilesController < Apps::ApplicationController

  def show
    @profile = Profile.find(params[:profile_id])
    # @profile = user.prepare_profile
    # # @profile.update(avatar: "#{user.avatar_image}")
    # if @profile.save
    #   redirect_to profile_path, notice: 'プロフィール更新！'
    # else
    #   flash,now[:error] = '更新できませんでした'
    #   render profile_path
    # end
  end

  def edit
    @profile = current_user.prepare_profile
  end

  def update
    # profileレコードがない場合、新たに作成する
    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path, notice:'アバター更新！'
    else
      flash,now[:error] = '更新できませんでした'
      render :edit
    end
  end

  private
  def profile_params
    # Binding.pry
    params.require(:profile).permit(:avatar)
  end
end