require_relative '../acceptance_helper'

feature 'User can comments questions' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'user commented question', js: true do
    sign_in(user)
    visit question_path(question)

    within 'form.new_comment' do
      fill_in 'comment[body]', with: 'My comment'
    end
    click_on 'Добавить комментарий'

    expect(page).to have_content 'My comment'
  end
end