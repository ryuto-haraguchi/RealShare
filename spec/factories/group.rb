FactoryBot.define do
  factory :group do
    name { Faker::Lorem.characters(number: 10) }
    description { Faker::Lorem.characters(number: 100) }
  end
end