require 'rails_helper'

describe "ゲストログイン機能" do
  before do
    visit root_path
  end  
  context "ゲストログイン" do
    it "ゲストログインボタンが表示される" do
      expect(page).to have_content "ゲスト"  
    end
    it "ゲストログインボタンをクリックすると、ゲストユーザーとしてログインできる" do
      click_link "ゲスト"
      expect(current_path).to eq posts_path
    end
  end

  context "ゲストログイン時のアクセス権限" do
    before do
      click_link "ゲスト"
    end
    it "ゲストユーザーはマイページにアクセスできない" do
      visit mypage_users_path
      expect(current_path).to eq root_path
    end
    it "ゲストユーザーは新規投稿ができない" do
      visit new_post_path
      expect(current_path).to eq root_path
    end
    it "ゲストユーザーはグループ作成ができない" do
      visit new_group_path
      expect(current_path).to eq root_path
    end
    it "ゲストユーザーはユーザー詳細にアクセスができない" do
      visit user_path(1)
      expect(current_path).to eq root_path
    end
    it "ゲストユーザーは投稿詳細にアクセスができない" do
      visit post_path(1)
      expect(current_path).to eq root_path
    end
    it "ゲストユーザーはグループ詳細にアクセスができない" do
      visit group_path(1)
      expect(current_path).to eq root_path
    end
  end

  context "ゲストログアウトができる" do
    before do
      click_link "ゲスト"
    end
    it "ログアウト後、トップページに遷移する" do
      find('.menu-btn').click
      click_link "Logout"
      expect(current_path).to eq root_path
    end
  end
  
end
