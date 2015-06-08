require 'rails_helper'

feature 'Create Question', %q{
In order to get answer from community
As an authenticated user
I want to be able to ask question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'authenticated user can see questions list' do
    sign_in(user)
    visit root_path

    expect(page).to have_content question.title
  end

  scenario 'authenticated user try created question' do
    visit questions_path
    sign_in(user)
    click_on 'Задать вопрос'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test Text'
    click_on 'Create Question'

    expect(page).to have_content 'Ваш вопрос добавлен'
    expect(page).to have_content 'Test question'
  end

  scenario 'non authenticated user try created question' do
    visit questions_path
    expect(page).to have_content question.title
    click_on 'Задать вопрос'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end