require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  let!(:user) { create(:user) }
  before do
    log_in_as(user)
  end

  describe 'POST #create' do
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
    before do
      @relationship = create(:relationship, follower_id: user.id)
    end

    it 'リクエストが成功すること' do
      delete relationship_path(@relationship.following_id), xhr: true
      expect(response.status).to eq 200
    end

    it 'フォローが解除されること' do
      expect do
        delete relationship_path(@relationship.following_id), xhr: true
      end.to change(Relationship, :count).by(-1)
    end
  end
end
