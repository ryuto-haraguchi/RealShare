FactoryBot.define do
  factory :notice do
    reason { Faker::Lorem.characters(number: 100) }
  end
end