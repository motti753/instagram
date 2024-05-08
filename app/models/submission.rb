# == Schema Information
#
# Table name: submissions
#
#  id         :bigint           not null, primary key
#  content    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Submission < ApplicationRecord
  belongs_to :user
  has_many_attached :images #画像複数枚投稿
end
