require_relative 'acceptance_helper'

feature 'Ad files to answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'user ads file when write answer', js: true do

    fill_in 'Новый ответ', with: 'Test Answer'
    find('.nested-fields input').set("#{Rails.root}/spec/spec_helper.rb")
    click_on 'Save'

    within 'div.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end

  scenario 'user ads also some file when write answer', js: true do

    fill_in 'Новый ответ', with: 'Test Answer'
    find('.nested-fields input').set("#{Rails.root}/spec/spec_helper.rb")
    click_on 'Добавить еще файл'
    find('.nested-fields + .nested-fields input').set("#{Rails.root}/spec/rails_helper.rb")
    click_on 'Save'

    within 'div.answers' do
      expect(page).to have_content 'spec_helper.rb'
      expect(page).to have_content 'rails_helper.rb'
    end
  end
end