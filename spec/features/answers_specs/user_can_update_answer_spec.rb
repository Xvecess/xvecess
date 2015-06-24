require_relative '../acceptance_helper'

feature 'User can Update his answer' do

  given!(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

  scenario 'authenticated user try update your answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Редактировать ответ'
    within '.edit_answer' do
      fill_in 'answer[body]', with: 'Обновленный текст'
      click_on 'Update'
    end

    expect(current_path).to eq question_path(answer.question)
    expect(page).to have_content 'Обновленный текст'
    expect(page).to_not have_content 'MyAnswer'
  end

  scenario 'authenticated user try update your answer with blank text', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Редактировать ответ'
    within '.edit_answer' do
      fill_in 'answer[body]', with: ''
      click_on 'Update'

      expect(page).to have_selector 'textarea'
      expect(page).to have_content 'Body can\'t be blank'
    end
  end

  scenario 'authenticated user try update not your answer' do
    visit question_path(question)

    expect(page).to_not have_content 'Редактировать ответ'
  end

  scenario 'non authenticated user try update answer' do
    visit question_path(question)

    expect(page).to_not have_content 'Редактировать ответ'
  end
end