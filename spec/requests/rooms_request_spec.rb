require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  describe 'GET #index' do
    let(:user){create(:user)}
    context 'ログインしている場合' do
      before do
        log_in_as(user)
      end

      it 'リクエストが成功すること' do
        get rooms_path
        expect(response.status).to eq 200
      end

      it '「メッセージ」と表示されていること' do
        get rooms_path
        expect(response.body).to include ("メッセージ")
      end
    end

    context 'ログインしていない場合' do
      it 'リクエストは302 OKとなること' do
        get rooms_path
        expect(response.status).to eq 302
      end

      it 'ログイン画面にリダイレクトすること' do
        get rooms_path
        expect(response).to redirect_to login_url
      end
    end
  end
end
