FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'testtest' }
    password_confirmation { 'testtest' }
    prefecture { '東京都' }
    city { '渋谷区' }
    town { '渋谷' }
  end
end