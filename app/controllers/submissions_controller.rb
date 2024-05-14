class SubmissionsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @submissions = Submission.all.order('created_at DESC')
  end

  def new
    @submission = current_user.submissions.build
  end

  def create
    @submission = current_user.submissions.build(submission_params)
    if @submission.save
      redirect_to submissions_path, notice: '保存できました'
    else
      flash.now[:error] = '保存できません。コンテンツと画像を確かめてください'
      render :new
    end
  end

  private
  def submission_params
    params.require(:submission).permit(:content, images: [])
  end
end