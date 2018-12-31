require 'spec_helper.rb'

RSpec.feature "Signing users out", js: true do
  let(:john)  { User.create(email: 'john@example.com', password: 'password') }

  before do
    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: john.email
    fill_in 'Password', with: john.password
    click_button 'Log in'
  end

  it 'successfully signs the user out' do
    visit root_path
    click_link 'Sign out'

    expect(page).to have_content('Signed out successfully.')
  end
end
