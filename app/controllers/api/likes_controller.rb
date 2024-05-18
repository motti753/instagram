class Api::LikesController < Api::ApplicationController
  before_action :authenticate_user!

  def create
    submission = Submission.find(params[:submission_id])
    @likes = submission.likes.create!(user_id: current_user.id)
    render json: { status: 'OK' }
  end

  def destroy
    submission = Submission.find(params[:submission_id])
    like = submission.likes.find_by!(user_id: current_user.id)
    like.destroy!
    render json: { status: 'OK' }
  end

  def show
    submission = Submission.find(params[:submission_id])
    like_status = current_user.has_liked?(submission)
    render json: { hasLiked: like_status }
  end
end