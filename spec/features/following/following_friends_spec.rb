require 'rails_helper'

RSpec.feature "Following Friends", js: true do
  let!(:john)  { User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password") }
  let!(:peter)  { User.create(first_name: "Peter", last_name: "Corn", email: "peter@example.com", password: "password") }

  fcontext "when signed in" do
    before do
      login_as john
      visit "/"
    end

    describe "the lounge page" do
      it "displays both users' names" do
        expect(page).to have_content(john.full_name)
        expect(page).to have_content(peter.full_name)
      end

      it "does not allow following oneself" do
        self_link = "/friendships?friend_id=#{john.id}"

        expect(page).not_to have_link("Follow", href: self_link)
      end

      it "has a follow link for other users" do
        other_link = "/friendships?friend_id=#{peter.id}"
        expect(page).to have_link("Follow", href: other_link)
      end
    end

    context "after following someone" do
      it "no longer shows that person's follow link" do
        follow_link = "a[href='/friendships?friend_id=#{peter.id}']"
        find(follow_link).click
        expect(page).not_to have_link("Follow", href: follow_link)
      end
    end
  end
end