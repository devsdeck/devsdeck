require "rails_helper"

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

  describe "#github" do
    it "should successfully create a user" do
      post :github
      expect(User.count).to eq(1)
    end
  end
end
