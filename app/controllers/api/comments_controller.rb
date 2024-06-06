class Api::CommentsController < Api::ApplicationController

  def index
    @submission = Submission.find(params[:submission_id])
    @comments = @submission.comments.order(:id)
    @contents = @comments.pluck(:content)
    @avatar = []
    @comments.each do |comment|
      @profile = Profile.find(comment.user_id)
      if @profile.avatar&.attached?
        @avatar.push(url_for(@profile.avatar_image))
      else
        @avatar.push(url_for('/assets/default-avatar-12a3f7379a4333007fa16fb67297f8a31c88580ccdaf11eb0be7323847c5641a.png'))
      end
    end

    @contents.to_json
    @avatar.to_json
  end

  def create
    submission = Submission.find(params[:submission_id])
    @comment = submission.comments.build(comment_params)
    @comment.save!

    # ユーザ名がコメントに含まれているか確認
    @userall = User.all
    render json: @comment
    @userall.each do |user|
      if(@comment.content.include?(user.account))
        send_email(@userall.find(@comment.user_id), user, @comment)
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end

  def send_email(user, includeuser, comment)
    CommentMailer.new_includeuser(user, includeuser, comment).deliver_now
  end
end