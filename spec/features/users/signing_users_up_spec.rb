require 'rails_helper'

RSpec.feature "User signup", js: true do
  scenario "with valid credentials" do
    visit root_path
    click_link "Sign up"

    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content("You have signed up successfully.")

    visit root_path
    expect(page).to have_content('John Doe')
  end
end
