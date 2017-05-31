require 'rails_helper'

feature 'User can past registration', %q{
  In order to ask the questions
  As an user
  I want to past registration
} do

  given(:user) { create(:user) }

  scenario 'User past registration on site' do
    visit new_user_registration_path
    fill_in 'Email', with: 'user_1@test.com'
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation  
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
