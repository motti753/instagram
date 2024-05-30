class CommentMailer < ApplicationMailer
  def new_includeuser(user, includeuser, comment)
    @user = user
    @includeuser = includeuser
    @comment = comment
    # mail to:Eメール, subject: 'タイトル'
    mail to: user.email, subject: '【お知らせ】コメントにメンションされました'
  end
end