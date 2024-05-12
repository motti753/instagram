class SubmissionsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @submissions = Submission.all
  end

  def new
    @submission = current_user.submissions.build
  end

  def create
    @submission = current_user.submissions.build(submission_params)
  end

  private
  def submission_params
    params.require(:submission).permit(:content, images: [])
  end
end