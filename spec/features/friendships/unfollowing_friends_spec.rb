require 'rails_helper'

RSpec.feature "Unfollowing a Friend", js: true do
  let!(:john)       { User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password") }
  let!(:sarah)      { User.create(first_name: "Sarah", last_name: "Anderson", email: "sarah@example.com", password: "password") }
  let!(:following)  { Friendship.create(user: john, friend: sarah) }

  before { login_as john }

  it "unfollows the friend" do
    visit '/'

    click_link 'My Lounge'
    # binding.pry
    accept_alert do
      click_link "Unfollow"
    end

    expect(page).to have_content(sarah.full_name + " unfollowed")
  end
end