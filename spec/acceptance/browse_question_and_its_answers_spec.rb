require 'rails_helper'

feature 'User can browse the questions with its answers', %q{
  In order to solve some problem
  As an user
  I want browse the questions with its answers
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 3, question: question, user: user) }

  scenario 'Signed in user tries to browse some q with its a' do
    sign_in(user)

    visit question_path(id: question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each do |a|
      expect(page).to have_content a.body
    end
  end
  scenario 'Unsigned in user tries to browse some q with its a' do
    visit question_path(id: question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each do |a|
      expect(page).to have_content a.body
    end
  end
end
