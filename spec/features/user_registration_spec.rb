require 'rails_helper'

describe "ユーザー登録機能" do
  before do
    visit root_path
  end
  context "ユーザー登録" do
    it "ユーザー登録ボタンが表示される" do
      expect(page).to have_content "新規登録"
    end
    it "ユーザー登録ボタンをクリックすると、新規登録ページに遷移する" do
      click_link "新規登録"
      expect(current_path).to eq new_user_registration_path
    end
    it "ユーザー登録に成功する" do
      user_name = Faker::Name.name
      user_email = Faker::Internet.email
      user_password = Faker::Internet.password(min_length: 6)
      
      click_link "新規登録"
      fill_in 'user_name', with: user_name
      fill_in 'user_email', with: user_email
      fill_in 'prefecture', with: "東京都"
      fill_in 'city', with: "渋谷区"
      fill_in 'town', with: "渋谷"
      fill_in 'user_password', with: user_password
      fill_in 'user_password_confirmation', with: user_password
      click_button "登録"
      expect(current_path).to eq mypage_users_path 
    end
  end
end