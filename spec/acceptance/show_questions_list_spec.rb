require 'rails_helper'

feature 'View questions list', %q{
  In order to solve a problem
  As a user
  I want to see the questions list
} do
  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 3, user: user) }

  scenario 'Signed in user can saw available questions list' do
    sign_in(user)
    visit @questions
    questions.each do |q|
      expect(page).to have_content q.body
    end
  end

  scenario 'Unsigned in user also can saw available questions list' do
    visit @questions
    questions.each do |q|
      expect(page).to have_content q.body
    end
  end
end
