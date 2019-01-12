require 'rails_helper'

RSpec.feature 'Listing Exercises', js: true do
  let!(:john) { User.create(email: 'john@example.com', password: 'password') }
  let!(:e1)   { john.exercises.create(duration: 20, details: "My body building activity", activity_date: 2.days.ago) }
  let!(:e2)   { john.exercises.create(duration: 55, details: "Weight lifting", activity_date: 2.days.ago) }

  before do
    login_as john
  end

  fit "shows user's workout for last 7 days" do
    visit root_path
    click_link 'My Lounge'

    expect(page).to have_content(e1.duration)
    expect(page).to have_content(e1.details)
    expect(page).to have_content(e1.activity_date)

    expect(page).to have_content(e2.duration)
    expect(page).to have_content(e2.details)
    expect(page).to have_content(e2.activity_date)
  end
end
