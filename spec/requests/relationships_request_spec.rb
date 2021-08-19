require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  describe 'POST #create' do
    let!(:user){create(:user)}
    before do
      log_in_as(user)
    end

      it 'リクエストが成功すること' do
        post relationships_path, xhr: true, params: FactoryBot.attributes_for(:relationship, follower_id: user.id)
        expect(response.status).to eq 200
      end

      it 'フォローが完了すること' do
        expect do
          post relationships_path, xhr: true, params: FactoryBot.attributes_for(:relationship, follower_id: user.id)
        end.to change(Relationship, :count).by(1)
      end
  end

  describe 'DELETE #destroy' do
  end
end
