require 'rails_helper'

feature 'User select best answer', %q{
The users were asked the question can
 mark one of the answers as best as
 he decided his problem} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, question_id: question.id,
                           user_id: user.id, best: false) }

  scenario 'user marked best answer' do
    sign_in(user)
    visit question_path(question)
    click_on 'Это лучший ответ'
    
    expect(page).to have_content "Пользователь #{question.user.email} отметил этот ответ, как лучший"
  end
end