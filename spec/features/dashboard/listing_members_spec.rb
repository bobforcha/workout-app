require 'rails_helper'

RSpec.feature 'Listing members', js: true do
  let!(:john)  { User.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password') }
  let!(:sarah)  { User.create(first_name: 'Sarah', last_name: 'Jones', email: 'sarah@example.com', password: 'password') }

  it 'shows a list of registered members' do
    visit root_path

    expect(page).to have_content('List of Members')
    expect(page).to have_content(john.full_name)
    expect(page).to have_content(sarah.full_name)
  end
end