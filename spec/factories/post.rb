FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.characters(number: 100) }
    category { 0 }
    prefecture { '東京都' }
    city { '渋谷区' }
    town { '渋谷' }
  end
end