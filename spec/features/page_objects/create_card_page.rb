require "rails_helper"

class CreateCardPage
  include Capybara::DSL

  def create(name:, desc:)
    visit("/")
    click_link "New Card"
    fill_in "card-name", with: name
    fill_in "card-description", with: desc
    select "TestTag", from: "tags_"
    click_button("Create")
  end
end
