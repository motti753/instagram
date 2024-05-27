class Api::CommentsController < Api::ApplicationController

  def index
    @submission = Submission.find(params[:submission_id])
    @comments = @submission.comments.order(:id)
    @contents = @comments.pluck(:content)
    @avatar = []
    @comments.each do |comment|
      @profile = Profile.find(comment.user_id)
      # @avatar.push(Rails.application.routes.url_helpers.rails_representation_url(@profile.avatar.variant({}), only_path: true))
      @avatar.push(url_for(@profile.avatar_image))
    end

    @contents.to_json
    @avatar.to_json
  end

  def create
    submission = Submission.find(params[:submission_id])
    @comment = submission.comments.build(comment_params)
    @comment.save!
    render json: @comment
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end