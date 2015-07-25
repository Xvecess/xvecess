require_relative '../acceptance_helper'

feature 'destroy files on  answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }
  given!(:attachment) { create(:attachment, attachable: answer) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Authenticated user can destroy files on your answer', js: true do

    within 'div.row.attached-file' do
      click_on 'Удалить файл'
    end
    visit current_path

    expect(page).to_not have_content 'rails_helper.rb'
  end
end