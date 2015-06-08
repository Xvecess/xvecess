require 'rails_helper'

feature 'User  an create answers for questions' do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'authenticated user try create answer' do
    sign_in(user)
    click_on 'MyQuestion'
    expect(current_path).to eq question_path(question)
    click_on 'Добавить ответ'
    fill_in 'answer[body]', with: 'Test Answer'
    click_on 'Save'
    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'Test Answer'
  end

  scenario 'authenticated user try create answer with blank body' do
    sign_in(user)
    click_on 'MyQuestion'
    expect(current_path).to eq question_path(question)
    click_on 'Добавить ответ'
    fill_in 'answer[body]', with: ''
    click_on 'Save'
    expect(current_path).to eq question_answers_path(question)
    expect(page).to have_content 'Body can\'t be blank'
  end

  scenario 'non authenticated user try create answer' do
    visit questions_path
    click_on 'MyQuestion'
    expect(current_path).to eq question_path(question)
    click_on 'Добавить ответ'
    expect(current_path).to eq new_user_session_path
  end
end