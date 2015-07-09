require_relative '../acceptance_helper'

feature 'Create Question', %q{
In order to get answer from community
As an authenticated user
I want to be able to ask question
} do

  given!(:user) { create(:user) }
  given!(:questions) { create_list(:question, 2, user_id: user.id) }

  scenario 'authenticated user can see questions list' do
    sign_in(user)
    visit root_path

    expect(page).to have_content 'MyQuestion', count: 2
  end

  scenario 'authenticated user try created question' do
    visit questions_path
    sign_in(user)
    click_on 'Задать вопрос'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test Text'
    click_on 'Create Question'

    expect(page).to have_content 'Question was successfully created'
    expect(page).to have_content 'Test question'
  end

  scenario 'non authenticated user try created question' do
    visit questions_path
    click_on 'Задать вопрос'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end
end