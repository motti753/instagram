require 'rails_helper'

RSpec.describe "Submissions", type: :request do
  let!(:user) {FactoryBot.create(:user)}
  let!(:submission) {FactoryBot.create_list(:submission, 2, user_id: user.id)}

  # indexメソッドのテスト
  describe 'GET /submissions' do
    it '200ステータスが返ってくる' do
      puts '投稿一覧が取得できるかテスト'
      get submissions_path
      expect(response).to have_http_status(200)
    end
  end

  # createメソッドのテスト
  describe 'POST /submissions' do
    context 'ログインしている場合' do
      before do
        # rails_helper.rbにconfigの定義を追加することで使用可能となるメソッドsign_in
        sign_in user
      end

      it '投稿が保存されている' do
        # attributes_forで{submission: {content: xxxx, content:xxxx}}の形式に成形している
        submission_params = attributes_for(:submission)
        puts 'ログイン状態の投稿保存テスト'
        puts submission_params
        post submissions_path({submission: submission_params})
        expect(response).to have_http_status(302)
        expect(Submission.last.content).to eq(submission_params[:content])
        # expect(Submission.last.content.body.to_plain_text).to eq(submission_params[:content])
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        # attributes_forで{submission: {content:xxxx}}の形式に成形している
        submission_params = attributes_for(:submission)
        puts 'ログインしていない状態の投稿保存テスト'
        puts submission_params
        post submissions_path({submission: submission_params})
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
