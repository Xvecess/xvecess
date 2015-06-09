require 'rails_helper'

feature 'User can Update his answer' do

  given!(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

  scenario 'authenticated user try update your answer' do
    sign_in(user)
    click_on 'MyQuestion'
    click_on 'Редактировать ответ'
    fill_in 'Ответ', with: 'Обновленный текст'
    click_on 'Save'

    expect(current_path).to eq question_path(answer.question)
    expect(page).to have_content 'Обновленный текст'
    expect(page).to_not have_content 'MyAnswer'
  end

  scenario 'authenticated user try update not your answer' do
    sign_in(user2)
    click_on 'MyQuestion'

    expect(page).to_not have_content 'Редактировать ответ'
  end

  scenario 'non authenticated user try update answer' do
    visit questions_path
    click_on 'MyQuestion'

    expect(page).to_not have_content 'Редактировать ответ'
  end
end