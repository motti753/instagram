class Api::CommentsController < Api::ApplicationController

  def index
    submission = Submission.find(params[:submission_id])
    comments = submission.comments
    render json: comments
  end

  def create
    submission = Submission.find(params[:submission_id])
    @comment = submission.comments.build(comment_params)
    @comment.save
    render json: @comment
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :submission_id)
  end
end