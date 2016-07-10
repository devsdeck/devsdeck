require "rails_helper"
require_relative "./page_objects/login_page"

RSpec.feature "user visits login page", :type => :feature do
  scenario "and logs in successfully" do
    user = FactoryGirl.create(:user)
    user.confirm
    LoginPage.new.login(email: user.email, password: user.password)

    expect(page).to have_content("Signed in successfully.")
    expect(current_path).to eq(root_path)
  end

  scenario "and can't login with wrong password" do
    user = FactoryGirl.create(:user)
    user.confirm
    login = LoginPage.new.login(email: user.email, password: "test")

    expect(page).to have_content("Invalid email or password.")
    expect(current_path).to eq(new_user_session_path)
  end
end
