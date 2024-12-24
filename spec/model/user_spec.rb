require 'rails_helper'

describe User do
  context "バリデーションテスト" do
    subject { FactoryBot.build(:user) } 
    shared_examples '空の場合、無効になる' do |column|
      it "#{column}が空の場合は無効" do
        subject.send("#{column}=", nil)
        expect(subject).to_not be_valid
      end
    end
    include_examples '空の場合、無効になる', :name
    include_examples '空の場合、無効になる', :email
    include_examples '空の場合、無効になる', :prefecture
    include_examples '空の場合、無効になる', :city
    include_examples '空の場合、無効になる', :town
    include_examples '空の場合、無効になる', :password

    it "名前が50文字以上の場合は無効" do
      subject.name = "a" * 51
      expect(subject).to_not be_valid
    end

    it "パスワードが6文字未満の場合は無効" do
      subject.password = "a" * 5
      expect(subject).to_not be_valid
    end

    it "パスワード確認が一致しない場合は無効" do
      subject.password_confirmation = "a" * 6
      expect(subject).to_not be_valid
    end
  end
end