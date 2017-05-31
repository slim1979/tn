require 'rails_helper'

feature 'User sign out', %q{
  In order to close session
  As an user
  I want to sign out
} do
  given!(:user) { create(:user) }

  scenario 'Signed in user tries to sign out' do
    sign_in(user)

    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
  end
  scenario 'Unsigned in user tries to sign out' do
    visit root_path
    expect(page).to_not have_link('Sign out')
  end
end
