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

  scenario 'Authenticated user created the question' do
    sign_in(user)

    visit @question
    click_on 'Ask question'
    fill_in 'Title', with: nil
    fill_in 'Body', with: nil
    click_on 'Create'

    expect(page).to have_content 'Title or body cant be blank. Try again'
  end

  scenario 'Unauthenticated user cant create any questions' do

    visit @question
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
