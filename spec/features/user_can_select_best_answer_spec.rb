require 'rails_helper'

feature 'User select best answer', %q{
The users were asked the question can
 mark one of the answers as best as
 he decided his problem} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }


  context 'with one answer on page' do

    given!(:answer) { create(:answer, question_id: question.id,
                             user_id: user.id, best: false) }

    scenario 'user marked best answer' do
      sign_in(user)
      visit question_path(question)

      within "##{answer.id}" do
        click_on 'Это лучший ответ'
      end

      expect(page).to have_content "Пользователь #{question.user.email} отметил этот ответ, как лучший"
    end
  end

  context 'with two answer on page' do

    given!(:answer1) { create(:answer, question_id: question.id,
                              user_id: user.id, best: true) }

    given!(:answer2) { create(:answer, question_id: question.id,
                              user_id: user.id, best: false) }

    scenario 'the best answer is displayed first' do
      sign_in(user)
      visit question_path(question)

      within "##{answer1.id}" do
        expect(page).to have_content "Пользователь #{question.user.email} отметил этот ответ, как лучший"
      end
      within "##{answer2.id}" do
        expect(page).to_not have_content "Пользователь #{question.user.email} отметил этот ответ, как лучший"
      end

      within ("##{answer2.id}") { click_on 'Это лучший ответ' }

      within "##{answer1.id}" do
        expect(page).to_not have_content "Пользователь #{question.user.email} отметил этот ответ, как лучший"
      end
      within "##{answer2.id}" do
        expect(page).to have_content "Пользователь #{question.user.email} отметил этот ответ, как лучший"
      end
    end
  end
end