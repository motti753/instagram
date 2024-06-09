# == Schema Information
#
# Table name: submissions
#
#  id         :bigint           not null, primary key
#  content    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_submissions_on_user_id  (user_id)
#
class Submission < ApplicationRecord
  validates :content, length: { minimum: 2}
  validates :content, length: { maximum: 300}

  belongs_to :user
  has_many_attached :images #画像複数枚投稿
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
