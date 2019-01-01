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
      fill_in 'Activity date', with: '2018-07-26'
      click_button 'Create Exercise'
    end

    fit "successfully creates the record" do
      exercise = Exercise.last
      expect(page).to have_content('Exercise has been created')
      expect(current_path).to eq(user_exercise_path(john, exercise))
      expect(exercise.user_id).to eq(john.id)
    end
  end
end
