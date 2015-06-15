require_relative 'acceptance_helper'

feature 'Ad files to question' do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'user ads file when ask question' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test Text'
    attach_file 'question_attachments_attributes_0_file', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create Question'
    click_on 'Test question'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

  scenario 'user ads also some file when ask question', js: true do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test Text'

    find('.nested-fields input').set("#{Rails.root}/spec/spec_helper.rb")
    click_on 'Добавить еще файл'
    find('.nested-fields + .nested-fields input').set("#{Rails.root}/spec/rails_helper.rb")
    click_on 'Create Question'
    click_on 'Test question'

    expect(page).to have_content 'spec_helper.rb'
    expect(page).to have_content 'spec_helper.rb'
  end
end