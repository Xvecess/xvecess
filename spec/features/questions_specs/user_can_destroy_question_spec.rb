require_relative '../acceptance_helper'

feature 'User can Update and Destroy  your question' do

  given!(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'authenticated user  destroy your question' do
    sign_in(user)
    click_on 'MyQuestion'
    click_on 'Удалить вопрос'

    expect(current_path).to eq questions_path
    expect(page).to_not have_content 'MyQuestion'
  end

  scenario 'authenticated user try  destroy not your question' do
    sign_in(user2)
    click_on 'MyQuestion'

    expect(page).to_not have_content 'Удалить вопрос'
  end

  scenario 'non authenticated user try destroy  question' do
    visit questions_path
    click_on 'MyQuestion'

    expect(page).to_not have_content 'Удалить вопрос'
  end
end
