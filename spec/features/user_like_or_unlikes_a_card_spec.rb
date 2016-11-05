require "rails_helper"
require_relative "./page_objects/login_page"

RSpec.describe "user reads cards", type: :feature do
  it "and successfully likes a card", js: true do
    FactoryGirl.create(:tag, name: "TestTag")
    user = FactoryGirl.create(:user)
    user.confirm
    card = FactoryGirl.create(:card, user: user)
    LoginPage.new.login(email: user.email, password: user.password)

    click_link("", href: "/cards/#{card.id}/like_or_unlike")
    wait_for_ajax
    expect(find("#likes_#{card.id}").text).to have_content("1")
  end

  it "and successfully unlikes a card", js: true do
    FactoryGirl.create(:tag, name: "TestTag")
    user = FactoryGirl.create(:user)
    user.confirm
    card = FactoryGirl.create(:card, user: user)
    LoginPage.new.login(email: user.email, password: user.password)

    click_link("", href: "/cards/#{card.id}/like_or_unlike")
    wait_for_ajax
    expect(find("#likes_#{card.id}").text).to have_content("1")

    click_link("", href: "/cards/#{card.id}/like_or_unlike")
    wait_for_ajax
    expect(find("#likes_#{card.id}").text).to have_content("0")
  end
end
