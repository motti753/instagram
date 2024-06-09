FactoryBot.define do
  factory :submission do
    content {Faker::Games::Pokemon.name}
  end
end