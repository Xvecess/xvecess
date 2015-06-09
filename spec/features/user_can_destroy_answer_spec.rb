require 'rails_helper'

feature 'User can Update and Destroy his answer' do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

  scenario 'authenticated user try destroy your answer' do
    sign_in(user)
    click_on 'MyQuestion'
    click_on 'Удалить ответ'

    expect(current_path).to eq question_path(answer.question)
    expect(page).to_not have_content 'MyAnswer'
  end

  scenario 'authenticated user try destroy not your answer' do
    sign_in(user2)
    click_on 'MyQuestion'

    expect(page).to_not have_content 'Удалить ответ'
  end

  scenario 'non authenticated user try destroy answer' do
    visit questions_path
    click_on 'MyQuestion'

    expect(page).to_not have_content 'Удалить ответ'
  end
end