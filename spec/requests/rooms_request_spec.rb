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

  describe 'POST #create' do
    context 'ログインしている場合' do
      let(:user){create(:user)}
      before do
        log_in_as(user)
      end

      it 'リクエストが成功すること' do
        post rooms_path, params: { entry: FactoryBot.attributes_for(:entry) }
        expect(response.status).to eq 302
      end

      it 'ルーム作成が完了すること' do
        expect do
          post rooms_path, params: { entry: FactoryBot.attributes_for(:entry1, user_id: user.id) }
        end.to change(Room, :count).by(1)
      end
    end

    context 'ログインしていない場合' do
      it 'リクエストは302 OKとなること' do
        get rooms_path, params: { entry: FactoryBot.attributes_for(:entry) }
        expect(response.status).to eq 302
      end

      it 'ログイン画面にリダイレクトすること' do
        get rooms_path, params: { entry: FactoryBot.attributes_for(:entry) }
        expect(response).to redirect_to login_url
      end
    end
  end

  describe 'GET #show' do
    let!(:user){create(:user)}
    let!(:user2){create(:user2)}

    context 'ログインしている場合' do
      before do
        log_in_as(user)
        @room = create(:room)
        @message = create(:message, user_id: user2.id, room_id: @room.id, message: 'Hello!')
        @entry1 = create(:entry1, user_id: user.id, room_id: @room.id)
        @entry2 = create(:entry1, user_id: user2.id, room_id: @room.id)
      end

      it 'リクエストが成功すること' do
        get room_path(@room.id)
        expect(response.status).to eq 200
      end

      it '相手の名前が表示されていること' do
        get room_path(@room.id)
        expect(response.body).to include 'user2'
      end

      it 'メッセージ内容が表示されていること' do
        get room_path(@room.id)
        expect(response.body).to include 'Hello!'
      end
    end

    context 'ログインしていない場合' do
      before do
        @room = create(:room)
        @message = create(:message, user_id: user2.id, room_id: @room.id, message: 'Hello!')
        @entry1 = create(:entry1, user_id: user.id, room_id: @room.id)
        @entry2 = create(:entry1, user_id: user2.id, room_id: @room.id)
      end

      it 'リクエストは302 OKとなること' do
        get room_path(@room.id)
        expect(response.status).to eq 302
      end

      it 'ログイン画面にリダイレクトすること' do
        get room_path(@room.id)
        expect(response).to redirect_to login_url
      end
    end
  end
end
