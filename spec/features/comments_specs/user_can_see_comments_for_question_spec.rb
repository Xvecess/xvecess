require_relative '../acceptance_helper'

feature 'User can delete  question comments' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:comments) { create_list(:comment, 2, commentable: question, user: user) }

  scenario 'user commented question', js: true do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content 'MyComment', count: 2
  end
end