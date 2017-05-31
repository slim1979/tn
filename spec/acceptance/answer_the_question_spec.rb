require 'rails_helper'

feature 'User can answer the question', %q{
  In order to solve somebody problem
  As an User
  I want to answer the question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Signed in User answer the question' do
    sign_in(user)

    visit question_path(id: question)
    save_and_open_page 

    fill_in 'answer_body', with: 'qwerty'
    click_on 'Save'

    expect(page).to have_content 'Thank your for your answer!'
  end

  scenario 'Unsigned in User tries answer the question' do
    visit question_path(id: question)

    expect(page).to_not have_button('Save')
  end

end
