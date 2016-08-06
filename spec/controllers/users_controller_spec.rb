require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }

  before do
    user.confirm
    sign_in user
  end

  describe "get #show" do
    it "assigns the correct values" do
      get :show, id: user.to_param

      expect(assigns(:user)).to eq(user)
      expect(assigns(:cards)).to eq([])
      expect(assigns(:liked)).to eq([])
      expect(assigns(:total_likes)).to eq(0)
      expect(assigns(:total_cards)).to eq(0)
    end
  end

  describe "get #edit" do
    it "assigns requested user to @user" do
      get :edit, id: user.to_param

      expect(assigns(:user)).to eq(user)
    end
  end

  describe "get #cards" do
    it "assigns all_cards to @all_cards" do
      get :cards, user_id: user.to_param

      expect(assigns(:all_cards)).to eq([])
    end
  end

  describe "get #likes" do
    it "assigns all_likes to @all_likes" do
      get :likes, user_id: user.to_param

      expect(assigns(:all_likes)).to eq([])
    end
  end
end
