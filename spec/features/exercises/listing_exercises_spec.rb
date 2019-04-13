require 'rails_helper'

RSpec.feature 'Listing Exercises', js: true do
  let!(:john) { User.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password') }
  let!(:sarah) { User.create(first_name: 'Sarah', last_name: 'Anderson', email: 'sarah@example.com', password: 'password') }

  before do
    login_as john
  end

  context 'when exercises are created' do
    let!(:e1)   { john.exercises.create(duration: 20, details: "My body building activity", activity_date: 4.days.ago) }
    let!(:e2)   { john.exercises.create(duration: 55, details: "Weight lifting", activity_date: 4.days.ago) }
    let!(:e3)   { john.exercises.create(duration: 30, details: "Squats", activity_date: 8.days.ago) }

    it "shows user's workout for last 7 days" do
      visit root_path
      click_link 'My Lounge'

      exercise_table = find('.table')
  
      expect(exercise_table).to have_content(e1.duration)
      expect(exercise_table).to have_content(e1.details)
      expect(exercise_table).to have_content(e1.activity_date)
  
      expect(exercise_table).to have_content(e2.duration)
      expect(exercise_table).to have_content(e2.details)
      expect(exercise_table).to have_content(e2.activity_date)

      expect(exercise_table).not_to have_content(e3.duration)
      expect(exercise_table).not_to have_content(e3.details)
      expect(exercise_table).not_to have_content(e3.activity_date)
    end

    context "and a friend is followed" do
      let!(:following)  { Friendship.create(user: john, friend: sarah) }

      it "shows a list of user's friends" do
        visit root_path
        click_link "My Lounge"

        expect(page).to have_content('My Friends')
        expect(page).to have_link(sarah.full_name)
        expect(page).to have_link('Unfollow')
      end
    end
  end

  context 'when no exercises are created' do
    it "shows no workouts" do
      visit root_path
      click_link 'My Lounge'

      expect(page).to have_content('No Workouts Yet')
    end
  end
end
