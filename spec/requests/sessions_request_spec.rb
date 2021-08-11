require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe 'GET #new' do
    it 'リクエストが成功すること' do
      get login_path
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    let!(:user2){create(:user2)}
    let(:params){{session: {email: user2.email, password: '000000'}}}
    let(:invalid_params){{session: {email: 'invalid@example.com', password: '000000'}}}

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post login_path, params: params
        expect(response.status).to eq 302
      end

      it 'リダイレクトすること' do
        post login_path, params: params
        expect(response).to redirect_to user_url(user2.id)
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post login_path, params: invalid_params
        expect(response.status).to eq 200
      end

      it 'エラーが表示されること' do
        post login_path, params: invalid_params
        expect(response.body).to include '無効なメールアドレス/パスワードの組み合わせです'
      end
    end
  end

end
