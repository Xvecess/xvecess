require_relative '../acceptance_helper'

feature 'User  an create answers for questions' do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user_id: user.id) }

  scenario 'authenticated user try create answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Новый ответ', with: 'Test Answer'
    click_on 'Save'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'Test Answer'
  end

  scenario 'authenticated user try create answer with blank body',js: true do
    sign_in(user)
    visit question_path(question)

    expect(current_path).to eq question_path(question)

    fill_in 'Новый ответ', with: ''
    click_on 'Save'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'Body can\'t be blank'
  end

  scenario 'non authenticated user try create answer'  do
    visit question_path(question)

    within ('.question_answers') do
      expect(page).to_not have_content 'Ваш ответ'
      expect(page).to_not have_content 'Save'
    end
  end
end
