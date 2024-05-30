class ApplicationMailer < ActionMailer::Base
  # デフォルト送信もとEmailアドレス
  default from: "from@example.com"
  # メール送信内容となるView
  layout "mailer"
end
