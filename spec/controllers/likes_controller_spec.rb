require "rails_helper"

RSpec.describe LikesController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:card) { FactoryGirl.create(:card) }

  before do
    user.confirm
    sign_in user
  end

  describe "POST #create" do
    it "creates a like on a card" do
      post :create, params: { card_id: card.id }, format: :js

      expect(card.reload.cached_votes_up).to eq(1)
    end
  end

  describe "DELETE #destroy" do
    it "deletes a like on a card" do
      card.upvote_by(user)

      delete :destroy, params: { card_id: card.id }, format: :js

      expect(card.reload.cached_votes_up).to eq(0)
    end

    it "does not downvote twice on double request" do
      delete :destroy, params: { card_id: card.id }, format: :js
      delete :destroy, params: { card_id: card.id }, format: :js

      expect(card.reload.cached_votes_down).to eq(1)
    end
  end
end
