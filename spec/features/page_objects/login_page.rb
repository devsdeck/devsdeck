require "rails_helper"

class LoginPage
  include Capybara::DSL

  def login(email:, password:)
    visit("/")
    click_link "Login"
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    click_button("Log in")
  end
end
