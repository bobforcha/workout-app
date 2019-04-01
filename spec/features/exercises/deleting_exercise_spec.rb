require 'rails_helper'

RSpec.feature 'Deleting exercise', js: true do
  let!(:owner)          { User.create(email: 'owner@example.com', password: 'password') }
  let!(:owner_exercise) { owner.exercises.create(duration: 48, details: "My body building activity", activity_date: Date.today) }
  let!(:path)           { "/users/#{owner.id}/exercises/#{owner_exercise.id}" }
  let!(:link)           { "//a[contains(@href,\'#{path}\') and .//text()='Destroy']" }

  before { login_as owner }

  fit 'successfully deletes the exercise' do
    visit root_path
    click_link "My Lounge"

    find(:xpath, link).click

    expect(page).to have_content("Exercise has been deleted")
  end
end