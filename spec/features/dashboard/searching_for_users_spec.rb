require 'rails_helper'

RSpec.feature 'Searching for users', js: true do
  let!(:john)  { User.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password') }
  let!(:sarah)  { User.create(first_name: 'Sarah', last_name: 'Doe', email: 'sarah@example.com', password: 'password') }

  fcontext "with existing name" do
    it 'returns all those users' do
      visit root_path
      fill_in 'search_name', with: 'Doe'
      click_button 'Search'

      expect(page).to have_content(john.full_name)
      expect(page).to have_content(sarah.full_name)
      expect(current_path).to eq('/dashboards/search')
    end
  end
end

