require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to ask the question
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user created the question' do

    sign_in(user)

    visit @question
    click_on 'Ask question'
    fill_in 'Title', with: 'Test title'
    fill_in 'Body', with: 'Test body'
    click_on 'Create'

    expect(page).to have_content 'Your question is successfully created!'
  end

  scenario 'Unauthenticated user cant create any questions' do

    visit @question

    expect(page).to_not have_button('Ask question')
  end
end
