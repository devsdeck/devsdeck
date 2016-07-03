require "rails_helper"

RSpec.describe TagsController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:tag) { FactoryGirl.create(:tag) }
  let(:attributes1) do
    { name: "Test", description: "This is a <b>test</b>", tags: [tag] }
  end
  let(:attributes2) do
    { name: "Test", description: "This is a <b>test</b>" }
  end

  before do
    user.confirm
    sign_in user
  end

  describe "GET #cards" do
    it "gets all the cards of a specific tag and assigns them to @cards" do
      card1 = Card.create(attributes1)
      card2 = Card.create(attributes2)
      get :cards, id: tag.id

      expect(assigns(:cards)).to eq([card1])
    end
  end
end
