require 'rails_helper'

RSpec.feature "User signup", js: true do
  before do
    visit root_path
    click_link 'Sign up'
  end

  fscenario "with valid credentials" do
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

  fscenario "with invalid credentials" do
    fill_in 'First name', with: ''
    fill_in 'Last name', with: ''
    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
  end


end
