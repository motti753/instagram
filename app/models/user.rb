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
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  before_create :prepare_profile

  def avatar_image
    # profileデータがある and profile.avatarがある
    if profile.avatar&.attached?
      avatar
    else
      'default-avatar.png'
    end
  end

  # 自分がフォローしている人を探し出す
  # has_many :代替え名, foreign_key: 'カラム名', class_name: 'テーブル名', dependent: :destroy
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  # user.followingsとすると、「自身のuser_id = follower_id」となっているレコードのfollowingカラムを取得する
  has_many :followings, through: :following_relationships, source: :following

  # 自分のフォロワーを探し出す
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  # user.followingsとすると、「自身のuser_id = follower_id」となっているレコードのfollowingカラムを取得する
  has_many :followers, through: :follower_relationships, source: :follower

  # followControllerで使う、
  # relationshipsテーブルにinsertするためのメソッド
  def follow!(user)
    user_id = get_user_id(user)
    following_relationships.create!(following_id: user_id)
  end

  # unfollowControllerで使う、
  # relationshipsテーブルにdestroyするためのメソッド
  def unfollow!(user)
    user_id = get_user_id(user)
    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy!
  end

  # profile.html.hamlで使用するrelationshipテーブルにレコードがあるかを判定する
  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
  end

  # ユーザに紐づくプロフィールがある場合、表示。
  # ない場合、新たにレコードを作成する
  def prepare_profile
    profile || build_profile
  end

  # like showでlikeテーブルにログインユーザ・投稿のlikeがあるか判定結果を戻り値とする
  def has_liked?(submission)
    likes.exists?(submission_id: submission.id)
  end

  def count_post(user)
    submission_count = Submission.where(user_id: user.id)
    submission_count.count
  end

  def count_follower(user)
    follower = follower_relationships.where(following_id: user.id)
    follower.count
  end

  def count_following(user)
    following = following_relationships.where(follower_id: user.id)
    following.count
  end

  private
  def get_user_id(user)
    if user.is_a?(User)
      user.id
    else
      user
    end
  end
end
