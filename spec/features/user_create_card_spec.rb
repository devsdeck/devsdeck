require "rails_helper"
require_relative "./page_objects/login_page"
require_relative "./page_objects/create_card_page"

RSpec.feature "user visits create card page", type: :feature do
  scenario "and successfully adds a card" do
    FactoryGirl.create(:tag, name: "TestTag")
    user = FactoryGirl.create(:user)
    user.confirm
    LoginPage.new.login(email: user.email, password: user.password)
    CreateCardPage.new.create(name: "test", desc: "this is a test")

    expect(page).to have_content("Card was successfully created.")
  end

  scenario "and can't add a card with no name" do
    FactoryGirl.create(:tag, name: "TestTag")
    user = FactoryGirl.create(:user)
    user.confirm
    LoginPage.new.login(email: user.email, password: user.password)
    CreateCardPage.new.create(name: "", desc: "this is a test")

    expect(page).to have_content("Name can't be blank")
  end
end
