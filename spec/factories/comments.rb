FactoryBot.define do
  factory :comment do
    content {Faker::Games::Pokemon.location}
  end
end