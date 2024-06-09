require 'rails_helper'

RSpec.describe Submission, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  # 前提条件と動作内容を分ける時に使用する
  context 'タイトルと内容が入力されている場合' do
    # [let!(:変数名)]は、変数名 = xxxx;と同じ意味。 do~endの間が変数に代入する値
    let!(:submission) {build(:submission, user: user)}

    # before do
    #   @submission = build(:submission, user: user)
    # end
    # 前提条件
    # before do
    #   user = User.create!({
    #     email: 'aaaaaa@gmail.com',
    #     password: 'password',
    #     account: Faker::Games::Pokemon.name
    #   })

    #   @submission = user.submissions.build({
    #     content: Faker::Games::Pokemon.location
    #   })
    # end

    it '投稿を保存できる' do
      # expect=期待する articleがto be_valid=保存できること
      expect(submission).to be_valid
    end
  end

  context '投稿の文字が空白の場合' do
    let!(:submission) {build(:submission, user: user, content: 'a')}
    before do
      # @submission = build(:submission, user: user, content: 'a')
      submission.save
    end

    it '投稿を保存できない' do
      expect(submission.errors.messages[:content][0]).to eq('は2文字以上で入力してください')
    end
  end
end
