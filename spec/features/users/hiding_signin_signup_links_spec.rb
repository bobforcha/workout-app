require 'spec_helper'

RSpec.feature "Hiding signin link", js: true do
  let(:john)  { User.create(email: 'john@example.com', password: 'password') }

  context 'when user is signed in' do
    before do
      visit root_path
      click_link 'Sign in'
      fill_in 'Email', with: john.email
      fill_in 'Password', with: john.password
      click_button 'Log in'
    end

    it 'hides the sign in and sign up links and shows the sign out link' do
      expect(page).to have_link('Sign out')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end
end
