require 'rails_helper'

feature 'Author can delete his own content', %q{
  In order to close discussion
  As an user
  I want to delete my content
} do

  given(:user)       { create(:user) }
  given(:user2)      { create(:user) }
  given(:question)   { create(:question, user: user) }
  given(:answers)    { create_list(:answer, 3, question: question) }

  scenario 'Author delete his own questions' do
    sign_in(user)

    visit questions_path(id: question)

    expect{ click_on 'Delete' }.to change(Question, :count).by(-1), change(Answer, :count)
  end

  scenario 'Author cant delete other authors questions' do
    sign_in(user2)
    visit questions_path(id: question)  

    expect(page).to_not have_link('Delete')
  end


end
