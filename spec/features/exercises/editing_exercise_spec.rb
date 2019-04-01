require 'rails_helper'

RSpec.feature 'Editing Exercise', js: true do
  let!(:owner)          { User.create(email: "owner@example.com", password: "password") }
  let!(:owner_exercise) { owner.exercises.create(duration: 48, details: "My body building activity", activity_date: Date.today) }
  let!(:path)           { "/users/#{owner.id}/exercises/#{owner_exercise.id}/edit" }
  let!(:link)           { "a[href=\'#{path}\']" }

  before { login_as owner }

  context 'with valid data' do
    it 'succeeds' do
      visit root_path
      click_link "My Lounge"

      find(link).click

      fill_in 'Duration', with: 45
      click_button 'Update Exercise'

      expect(page).to have_content("Exercise has been updated")
      expect(page).to have_content(45)
      expect(page).not_to have_content(48)
    end
  end
end


