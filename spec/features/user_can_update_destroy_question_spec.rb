require 'rails_helper'

feature 'User can Update and Destroy  his question' do

  given!(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user_id: user.id) }

  scenario 'authenticated user  try update his question' do
    sign_in(user)
    click_on 'MyQuestion'
    click_on 'Редактировать вопрос'
    fill_in 'question[body]', with: 'Обновленный текст'
    click_on 'Update Question'
    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'Обновленный текст'
  end

  scenario 'authenticated user try  update not his question' do
    sign_in(user2)
    click_on 'MyQuestion'
    expect(page).to_not have_content 'Редактировать вопрос'
  end

  scenario 'non-authenticated user try  update  question' do
    visit questions_path
    click_on 'MyQuestion'
    expect(page).to_not have_content 'Редактировать вопрос'
  end

  scenario 'authenticated user  destroy his question' do
    sign_in(user)
    click_on 'MyQuestion'
    click_on 'Удалить вопрос'
    expect(current_path).to eq questions_path
    expect(page).to_not have_content 'MyQuestion'
  end

  scenario 'authenticated user try  destroy not his question' do
    sign_in(user2)
    click_on 'MyQuestion'
    expect(page).to_not have_content 'Удалить вопрос'
  end

  scenario 'non-authenticated user try destroy  question' do
    visit questions_path
    click_on 'MyQuestion'
    expect(page).to_not have_content 'Удалить вопрос'
  end
end
