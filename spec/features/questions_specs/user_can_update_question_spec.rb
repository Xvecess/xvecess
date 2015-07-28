require_relative '../acceptance_helper'

feature 'User can Update and Destroy  your question' do

  given!(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'authenticated user  try update your question' do
    sign_in(user)
    click_on 'MyQuestion'
    click_on 'Редактировать вопрос'
    fill_in 'Body', with: 'Обновленный текст'
    click_on 'Update Question'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'Обновленный текст'
    expect(page).to_not have_content 'MyText'
  end

  scenario 'authenticated user try  update not your question' do
    sign_in(user2)
    click_on 'MyQuestion'

    expect(page).to_not have_content 'Редактировать вопрос'
  end

  scenario 'non authenticated user try  update  question' do
    visit questions_path
    click_on 'MyQuestion'

    expect(page).to_not have_content 'Редактировать вопрос'
  end
end