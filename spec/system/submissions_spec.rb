require 'rails_helper'
require 'capybara/rails'

RSpec.describe "Submissions", type: :system do
  let!(:user) {FactoryBot.create(:user)}
  let!(:submissions) {FactoryBot.create_list(:submission, 2, user: user)}

  # submission index
  it '投稿一覧が表示される' do
    visit root_path
    submissions.each do |submission|
      # pageにartilce最初のタイトルが存在しているか
      # expect(page).to have_content(article.title)
      # pageの.card_titleクラスにarticle.titleが存在するか
      expect(page).to have_css('.submission_content', text: submission.content)
    end
  end

  # submission show
  it '投稿の詳細を表示できる' do
    visit root_path

    submission = submissions[0]
    puts submission.content

    # .submission_contentクラス要素にsubmission.contentが存在すること
    expect(page).to have_css('.submission_content', text: submission.content)
    # .submission_contentクラス要素にsubmission.contentが存在すること
    # to_plain_textはactionDecorationで変換されているものを文字列に直したもの
    # expect(page).to have_css('.article_content', text: article.content.to_plain_text)
  end
end
