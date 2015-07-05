require_relative '../acceptance_helper'

feature 'User can delete  question comments' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:comment) { create(:comment, commentable: question, user: user) }

  scenario 'user commented question', js: true do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content 'MyComment'

    within '.question-comments-list' do
      click_on 'Удалить комментарий'
    end

    expect(page).to_not have_content 'My comment'
  end
end