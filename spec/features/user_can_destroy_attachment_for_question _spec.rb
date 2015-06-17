require_relative 'acceptance_helper'

feature 'destroy files on  question' do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:attachment) { create(:attachment, attachable: question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Authenticated user can destroy files on your question', js: true do

    within '.attached-files' do
      click_on 'Удалить файл'
    end

    expect(page).to_not have_content 'spec_helper.rb'
  end
end