require_relative 'acceptance_helper'

feature 'destroy files on  question' do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test Text'
    find('.nested-fields input').set("#{Rails.root}/spec/spec_helper.rb")
    click_on 'Create Question'
    click_on 'Test question'
  end
  scenario 'Authenticated user can destroy files on your question', js: true do

    within '.attached-files' do
      click_on 'Удалить файл'
    end
    expect(page).to_not have_content 'spec_helper.rb'
  end
end