require 'rails_helper'

feature 'Author can delete his own answers', %q{
  In order to change answers
  As an user
  I want to delete my answers
} do

  given!(:user)       { create(:user) }
  given!(:user2)      { create(:user) }
  given!(:question)   { create(:question, user: user) }
  given!(:answers)    { create(:answer, question: question) }

  scenario 'Author delete his own answers' do
    sign_in(user)

    visit question_path(id: question)
    expect{ click_on 'Delete' }.to change(Answer, :count)
  end

  scenario 'Author cant delete other authors answers' do
    sign_in(user2)
    visit question_path(id: question)

    expect(page).to_not have_link('Delete')
  end
end
