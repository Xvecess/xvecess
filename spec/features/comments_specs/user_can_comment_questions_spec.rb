require_relative '../acceptance_helper'

feature 'User can comments questions' do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:question2) { create(:question, user: user2) }
  given(:answer) { create(:answer, user: user, question: question) }
  given(:answer2) { create(:answer, user: user2, question: question2) }

  scenario 'user commented question', js: true do
    sign_in(user)
    visit question_path(question)

    within 'form.comment' do
      fill_in 'comment[body]', with: 'My comment'
    end
    click_on 'Добавить комментарий'

    expect(page).to have_content 'My comment'
  end
end