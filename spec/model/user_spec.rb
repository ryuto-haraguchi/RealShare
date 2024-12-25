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

  context "メソッドテスト" do
    it "self.guest" do
      expect{ User.guest }.to change { User.count }.by(1)
    end

    it "guest_user?" do
      user = User.guest
      expect(user.guest_user?).to eq true
    end

    it "full_address" do
      user = FactoryBot.build(:user)
      expect(user.full_address).to eq "#{user.prefecture}#{user.city}#{user.town}"
    end

    it "user_leave" do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      comment = FactoryBot.create(:comment, post: post, user: user)
      own_group = FactoryBot.create(:group, owner: user)
      group_user = FactoryBot.create(:group_user, user: user, group: own_group)
      bookmark = FactoryBot.create(:bookmark, user: user, post: post)
      notice = FactoryBot.create(:notice, user: user, noticeable: post)
      expect(Post.count).to eq(1)
      expect(Comment.count).to eq(1)
      expect(Group.count).to eq(1)
      expect(GroupUser.count).to eq(1)
      expect(Bookmark.count).to eq(1)
      expect(Notice.count).to eq(1)

      expect { user.update(is_active: false) }.to change { Post.count }.by(-1)
                                             .and change { Comment.count }.by(-1)
                                             .and change { Group.count }.by(-1)
                                             .and change { GroupUser.count }.by(-1)
                                             .and change { Bookmark.count }.by(-1)
                                             .and change { Notice.count }.by(-1)
    end
  end
end