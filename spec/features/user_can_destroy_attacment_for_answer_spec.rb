# require_relative 'acceptance_helper'
#
# feature 'destroy files on  answer' do
#
#   given(:user) { create(:user) }
#   given(:question) { create(:question, user_id: user.id) }
#
#   background do
#
#     sign_in(user)
#     visit question_path(question)
#     fill_in 'Новый ответ', with: 'Test Answer'
#     find('.nested-fields input').set("#{Rails.root}/spec/rails_helper.rb")
#     click_on 'Save'
#   end
#
#   scenario 'Authenticated user can destroy files on your answer', js: true do
#
#     within 'div.row.attached-file' do
#       click_on 'Удалить файл'
#       question.reload
#       expect(page).to_not have_content 'rails_helper.rb'
#     end
#   end
# end