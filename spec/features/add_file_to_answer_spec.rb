require_relative 'acceptance_helper'

feature 'Ad files to answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'user ads file when ask question', js: true do
    fill_in 'Новый ответ', with: 'Test Answer'
    attach_file 'Добавить файл', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Save'

    within 'div.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end