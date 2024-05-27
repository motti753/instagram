class Apps::ProfilesController < Apps::ApplicationController

  def show
    @profile = Profile.find(params[:profile_id])
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
    params.require(:profile).permit(:avatar)
  end
end