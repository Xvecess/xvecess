require_relative 'acceptance_helper'

feature 'Ad files to question' do

  given(:user) { create(:user)}

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'user ads file when ask question' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test Text'
    attach_file 'Добавить файл', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create Question'
    click_on 'Test question'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end