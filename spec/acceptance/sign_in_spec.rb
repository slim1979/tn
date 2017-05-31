require 'rails_helper'

feature 'User sign in', %q{
  In order to ask the question
  As an User
  I want to sign in
} do

  given(:user) { create(:user) }

  scenario 'Registered user tries to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Unregistered user tries to sign in' do

    visit new_user_session_path
    fill_in 'Email', with: 'nonuser@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end
end