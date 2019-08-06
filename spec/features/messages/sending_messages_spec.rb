require 'rails_helper'

RSpec.describe "Sending a messsage", js: true do
  let!(:john)     { User.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password') }
  let!(:sarah)    { User.create(first_name: 'Sarah', last_name: 'Anderson', email: 'sarah@example.com', password: 'password') }
  let!(:henry)    { User.create(first_name: 'Henry', last_name: 'Flynn', email: 'henry@example.com', password: 'password') }
  let!(:room_name) { john.first_name + '-' + john.last_name }
  let!(:room)     { Room.create(name: room_name, user_id: john.id) }

  before do
    login_as john

    Friendship.create(user: sarah, friend: john)
    Friendship.create(user: henry, friend: john)
  end

  it "shows in chatroom window" do
    visit root_path

    click_link "My Lounge"
    expect(page).to have_content(room_name)

    fill_in "message-field", with: "Hello"
    click_button "Post"

    expect(page).to have_content("Hello")

    within("#followers") do
      expect(page).to have_link(sarah.full_name)
      expect(page).to have_link(henry.full_name)
    end
  end
end