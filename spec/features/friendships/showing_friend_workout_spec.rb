require 'rails_helper'

RSpec.feature "Showing friend workout", js: true do
  let!(:john)       { User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password") }
  let!(:sarah)      { User.create(first_name: "Sarah", last_name: "Anderson", email: "sarah@example.com", password: "password") }
  let!(:e1)         { john.exercises.create(duration: 74, details: "My shit", activity_date: Date.today) }
  let!(:e2)         { sarah.exercises.create(duration: 55, details: "Nuh uh, my shit", activity_date: Date.today) }
  let!(:e3)         { sarah.exercises.create(duration: 50, details: "Other shit", activity_date: Date.yesterday) }
  let!(:following)  { Friendship.create(user: john, friend: sarah) }

  before do
    login_as john
  end

  it "shows friend's workout for last 7 days" do
    visit root_path
    click_link "My Lounge"
    click_link sarah.full_name

    expect(page).to have_content("#{sarah.full_name}'s Exercises")
    expect(page).to have_content(e2.details)
    expect(page).to have_css("div#chart")
  end
end