require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let!(:user){create(:user)}
    before do
      log_in_as(user)
    end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post messages_path, xhr: true, params: { message: FactoryBot.attributes_for(:message) }
        expect(response.status).to eq 200
      end

      it 'メッセージ送信が完了すること' do
        expect do
          post messages_path, xhr: true, params: { message: FactoryBot.attributes_for(:message) }
        end.to change(Message, :count).by(1)
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post messages_path, xhr: true, params: { message: FactoryBot.attributes_for(:message, message: nil) }
        expect(response.status).to eq 200
      end

      it 'メッセージ送信が完了しないこと' do
        expect do
          post messages_path, xhr: true, params: { message: FactoryBot.attributes_for(:message, message: nil) }
        end.to_not change(Message, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @message = create(:message)
      @user = @message.user
      log_in_as(@user)
    end

    it 'リクエストが成功すること' do
      delete message_path(@message.id), xhr: true, params: {message: {room_id: @message.room_id}}
      expect(response.status).to eq 200
    end

    it 'メッセージが削除されること' do
      expect do
        delete message_path(@message.id), xhr: true, params: {message: {room_id: @message.room_id}}
      end.to change(Message, :count).by(-1)
    end
  end
end
