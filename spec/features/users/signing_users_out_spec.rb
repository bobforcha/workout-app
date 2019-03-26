require 'rails_helper'

RSpec.feature "Signing users out", js: true do
  let!(:john)  { User.create(email: 'john@example.com', password: 'password') }

  before do
    login_as john
  end

  xit 'successfully signs the user out' do
    visit root_path
    click_link 'Sign out'

    expect(page).to have_content('Signed out successfully.')
  end
end
