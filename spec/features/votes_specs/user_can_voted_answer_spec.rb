require_relative '../acceptance_helper'

feature 'User can voted answer' do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:question2) { create(:question, user: user2) }
  given!(:answer) { create(:answer, user: user, question: question) }
  given!(:answer2) { create(:answer, user: user2, question: question2) }

  background do
    sign_in(user2)
    visit question_path(question)
  end

  scenario 'display answer vote sum ' do
    expect(page).to have_selector '.vote-count', text: '0'
  end

  scenario 'user vote up answer ', js: true do

    within '.answer-votes' do
      expect(page).to have_selector '.vote-count', text: '0'
      find('a.answer-vote-up').click

      expect(page).to have_selector '.vote-count', text: '1'
    end
  end

  scenario 'user vote answer down ', js: true do

    within '.answer-votes' do
      expect(page).to have_selector '.vote-count', text: '0'
      find('a.answer-vote-down').click

      expect(page).to have_selector '.vote-count', text: '-1'
    end
  end

  scenario 'user can destroy your vote for answer ', js: true do

    within '.answer-votes' do
      expect(page).to have_selector '.vote-count', text: '0'
      find('a.answer-vote-up').click

      expect(page).to have_selector '.vote-count', text: '1'
      find('a.answer-vote-reload').click

      expect(page).to have_selector '.vote-count', text: '0'
    end
  end

  scenario 'answer owner can not voted ', js: true do

    visit question_path(question2)

    within '.answer-votes' do
      expect(page).to have_selector '.vote-count', text: '0'
      find('a.answer-vote-up').click

      expect(page).to have_selector '.vote-count', text: '0'
    end
  end
end