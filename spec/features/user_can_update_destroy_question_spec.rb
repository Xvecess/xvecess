require 'rails_helper'

feature 'User can Update and Destroy  his question' do

  given!(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user_id: user.id) }

  scenario 'authenticated user  update his question' do
    sign_in(user)
    click_on 'MyQuestion'
    click_on 'Редактировать вопрос'
    fill_in 'question[body]', with: 'Обновленный текст'
    click_on 'Update Question'
    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'Обновленный текст'
  end

  scenario 'authenticated user can  update not his question' do
    sign_in(user2)
    click_on 'MyQuestion'
    expect(page).to_not have_content 'Редактировать вопрос'
  end

  scenario 'non-authenticated user can  update  question' do
    visit questions_path
    click_on 'MyQuestion'
    expect(page).to_not have_content 'Редактировать вопрос'
  end


end
