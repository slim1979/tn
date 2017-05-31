require 'rails_helper'

feature 'View question list', %q{
  In order to solve a problem
  As a user
  I want to see the question list
} do
  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 3, user: user) }

  scenario 'Signed in user can saw available questions list' do
    sign_in(user)
    visit @question
    questions.each do |q|
      expect(page).to have_content q.body
    end
  end

  scenario 'Unsigned in user also can saw available questions list' do
    visit @question
    questions.each do |q|
      expect(page).to have_content q.body
    end
  end
end
