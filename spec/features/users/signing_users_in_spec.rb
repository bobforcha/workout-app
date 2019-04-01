require 'rails_helper'

RSpec.feature "User signin", js: true do
  let(:john) { User.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password') }

  scenario "with valid credentials" do
    visit root_path
    click_link 'Sign in'

    fill_in 'Email', with: john.email
    fill_in 'Password', with: john.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content("Signed in as #{john.email}")
  end
end
