# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  account                :string           not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_account               (account) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :profile, dependent: :destroy
  has_many :submissions, dependent: :destroy
  before_create :prepare_profile

  # ユーザに紐づくプロフィールがある場合、表示。
  # ない場合、新たにレコードを作成する
  def prepare_profile
    profile || build_profile
  end

end
