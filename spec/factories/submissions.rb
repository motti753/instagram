FactoryBot.define do
  factory :submission do
    content {Faker::Games::Pokemon.name}

    #afterメソッド。Postインスタンスをbuildした後、画像をつける。
    after(:build) do |submission|
      submission.images.attach(io: File.open('spec/fixtures/20240326_Wordpress_item3.jpg'), filename: 'test_image.png', content_type: 'image/png')

      submission.images.attach(io: File.open('spec/fixtures/avenue-815297_1280.jpg'), filename: 'test_image.png', content_type: 'image/png')

      submission.images.attach(io: File.open('spec/fixtures/grass-3375344_1280.jpg'), filename: 'test_image.png', content_type: 'image/png')

      submission.images.attach(io: File.open('spec/fixtures/tree-736885_1280.jpg'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end