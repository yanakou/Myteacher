require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET #index' do
    before do
      user2 = create(:user2)
      log_in_as(user2)
    end

    it 'リクエストが成功すること' do
      get users_path
      expect(response.status).to eq 200
    end

    it 'ユーザー名が表示されていること' do
      get users_path
      expect(response.body).to include("user2")
    end
  end

  describe 'GET #show' do
    before do
      @user2 = create(:user2)
      log_in_as(@user2)
    end

    it 'リクエストが成功すること' do
      get user_path(@user2.id)
      expect(response.status).to eq 200
    end

    it 'ユーザー名が表示されていること' do
      get user_path(@user2.id)
      expect(response.body).to include("user2")
    end

    context 'ユーザーが存在しない場合' do
      subject { -> { get user_path 1 } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #new' do
    it 'リクエストが成功すること' do
      get signup_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET #edit' do
    before do
      @user2 = create(:user2)
      log_in_as(@user2)
    end

    it 'リクエストが成功すること' do
      get edit_user_path(@user2.id)
      expect(response.status).to eq 200
    end

    it 'ユーザー名が表示されていること' do
      get edit_user_path(@user2.id)
      expect(response.body).to include 'user2'
    end

    it 'メールアドレスが表示されていること' do
      get edit_user_path(@user2.id)
      expect(response.body).to include 'user2@example.com'
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post users_path, params: { user: FactoryBot.attributes_for(:user) }
        expect(response.status).to eq 302
      end

      it 'ユーザーが登録されること' do
        expect do
          post users_path, params: { user: FactoryBot.attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      it 'リダイレクトすること' do
        post users_path, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to User.last
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post users_path, params: { user: FactoryBot.attributes_for(:user, name: nil) }
        expect(response.status).to eq 200
      end

      it 'ユーザーが登録されないこと' do
        expect do
          post users_path, params: { user: FactoryBot.attributes_for(:user, name: nil) }
        end.to_not change(User, :count)
      end

      it 'エラーが表示されること' do
        post users_path, params: { user: FactoryBot.attributes_for(:user, name: nil) }
        expect(response.body).to include '名前を入力してください'
      end
    end
  end

  describe 'PUT #update' do
    before do
      @user2 = create(:user2)
      log_in_as(@user2)
    end

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        put user_path(@user2.id), params: { user: FactoryBot.attributes_for(:user3) }
        expect(response.status).to eq 302
      end

      it 'ユーザー名が更新されること' do
        expect do
          put user_path(@user2.id), params: { user: FactoryBot.attributes_for(:user3) }
        end.to change { User.find(@user2.id).name }.from('user2').to('user3')
      end

      it 'リダイレクトすること' do
        put user_path(@user2.id), params: { user: FactoryBot.attributes_for(:user3) }
        expect(response).to redirect_to User.last
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        put user_path(@user2.id), params: { user: FactoryBot.attributes_for(:user3, name: nil) }
        expect(response.status).to eq 200
      end

      it 'ユーザー名が変更されないこと' do
        expect do
          put user_path(@user2.id), params: { user: FactoryBot.attributes_for(:user3, name: nil) }
        end.to_not change(User.find(@user2.id), :name)
      end

      it 'エラーが表示されること' do
        put user_path(@user2.id), params: { user: FactoryBot.attributes_for(:user3, name: nil) }
        expect(response.body).to include '名前を入力してください'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }
    before do
      log_in_as(user)
    end

    it 'リクエストが成功すること' do
      delete user_url(user.id)
      expect(response.status).to eq 302
    end

    it 'ユーザーが削除されること' do
      expect do
        delete user_url(user.id)
      end.to change(User, :count).by(-1)
    end

    it 'ユーザー一覧にリダイレクトすること' do
      delete user_url(user.id)
      expect(response).to redirect_to users_url
    end
  end

  # before do
  #   @user = create(:user)
  #   @other_user = create(:user2)
  # end

  # describe "GET /signup" do
  #   it "ログインページの表示に成功すること" do
  #     get signup_path
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /users" do
  #   context "非ログイン時" do
  #     it "ユーザー一覧ページにアクセスすると、ログインページにリダイレクトすること" do
  #       get users_path
  #       expect(response).to redirect_to login_url
  #     end
  #   end
  # end

  # describe "GET /users/:id/edit" do
  #   context "非ログイン時" do
  #     it "編集ページにアクセスすると、ログインページにリダイレクトすること" do
  #       get edit_user_path(@user)
  #       expect(flash).to_not be_empty
  #       expect(response).to redirect_to login_url
  #     end
  #   end

  #   context "異なるユーザーでログインを試みた場合" do
  #     it "編集ページにアクセスすると、ルートurlにリダイレクトすること" do
  #       log_in_as(@other_user)
  #       get edit_user_path(@user)
  #       expect(flash).to be_empty
  #       expect(response).to redirect_to root_url
  #     end
  #   end
  # end

  # describe "PATCH /users/:id" do
  #   context "非ログイン時" do
  #     it "編集を試みると、ログインページにリダイレクトすること" do
  #       patch user_path(@user), params: { user: { name: @user.name,
  #                                             email: @user.email } }
  #       expect(flash).to_not be_empty
  #       expect(response).to redirect_to login_url
  #     end
  #   end

  #   context "異なるユーザーでログインを試みた場合" do
  #     it "編集を試みると、ルートurlにリダイレクトすること" do
  #       log_in_as(@other_user)
  #       patch user_path(@user), params: { user: { name: @user.name,
  #                                                 email: @user.email } }
  #       expect(flash).to be_empty
  #       expect(response).to redirect_to root_url
  #     end
  #   end

  #   context "管理者でないユーザーがログイン" do
  #     it "admin属性を変更できないこと" do
  #       log_in_as(@other_user)
  #       expect(@other_user.admin?).to be_falsey
  #       patch user_path(@other_user), params: {user: { password: '000000',
  #                                           password_confirmation: '000000',
  #                                           admin: true } }
  #       expect(@other_user.reload.admin?).to be_falsey
  #     end
  #   end
  # end

  # describe "DELETE /users/:id" do
  #   context "非ログイン時" do
  #     it "ユーザーの削除に失敗し、ログインページにリダイレクトすること" do
  #       expect do
  #         delete user_path(@user)
  #       end.to_not change{User.count}
  #       expect(response).to redirect_to login_url
  #     end
  #   end

  #   context "管理者でないユーザーがログイン" do
  #     it "ユーザーの削除に失敗し、ログインページにリダイレクトすること" do
  #       log_in_as(@other_user)
  #       expect do
  #         delete user_path(@user)
  #       end.to_not change{User.count}
  #       expect(response).to redirect_to root_url
  #     end
  #   end
  # end
end
