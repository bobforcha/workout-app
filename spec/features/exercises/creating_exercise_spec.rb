require 'rails_helper'

RSpec.feature 'Creating exercise', js: true do
  let!(:john)      { User.create(email: 'john@example.com', password: 'password') }

  before do
    login_as john

    visit root_path
    click_link 'My Lounge'
    click_link 'New Workout'
  end

  describe 'New exercise page' do
    it 'has a Back link' do
      expect(page).to have_link('Back')
    end
  end

  context 'with valid inputs' do
    before do
      fill_in 'Duration', with: 70
      fill_in 'Workout Details', with: 'Weight lifting'
      fill_in 'Activity date', with: 5.days.ago
      click_button 'Create Exercise'
    end

    it "successfully creates the record" do
      exercise = Exercise.last
      expect(page).to have_content('Exercise has been created')
      expect(current_path).to eq(user_exercise_path(john, exercise))
      expect(exercise.user_id).to eq(john.id)
    end
  end

  context 'with invalid inputs' do
    before do
      fill_in 'Duration', with: ""
      fill_in 'Workout Details', with: ""
      fill_in 'Activity date', with: ""
      click_button 'Create Exercise'
    end

    it 'renders the new exercise page with appropriate error message' do
      expect(page).to have_content("Exercise has not been created")
      expect(page).to have_content("Duration is not a number")
      expect(page).to have_content("Details can't be blank")
      expect(page).to have_content("Activity date can't be blank")
    end
  end
end
