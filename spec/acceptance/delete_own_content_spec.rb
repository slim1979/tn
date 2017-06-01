require 'rails_helper'

feature 'Author can delete his own content', %q{
  In order to close discussion
  As an user
  I want to delete my content
} do

  given(:user)       { create(:user) }
  given(:questions)  { create(:question, user: user) }
  given(:answers)    { create_list(:answer, 3, question: question) }

  scenario 'Author delete his own content' do
    sign_in(user)

    visit questions_path(id: questions)

    expect{ click_on 'Delete' }.to change(Question, :count).by(-1) 
  end
end
