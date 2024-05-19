# == Schema Information
#
# Table name: comments
#
#  id            :bigint           not null, primary key
#  content       :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  submission_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_comments_on_submission_id  (submission_id)
#  index_comments_on_user_id        (user_id)
#
class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :article
  belongs_to :user
end
