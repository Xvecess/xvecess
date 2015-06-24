require_relative '../acceptance_helper'

feature 'User can voted answer or question' do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:question2) { create(:question, user: user2) }

  background do
    sign_in(user2)
    visit question_path(question)
  end

  scenario 'display vote sum ' do
    expect(page).to have_selector '.vote-question-count', text: '0'
  end

  scenario 'user vote question up ', js: true do
    within '.question-votes' do

      expect(page).to have_selector '.vote-question-count', text: '0'
      find('a.question-vote-up').click

      expect(page).to have_selector '.vote-question-count', text: '1'
    end
  end

  scenario 'user vote question down ', js: true do
    within '.question-votes' do
      expect(page).to have_selector '.vote-question-count', text: '0'
      find('a.question-vote-down').click

      expect(page).to have_selector '.vote-question-count', text: '-1'
    end
  end

  scenario 'user can destroy your vote for question ', js: true do
    within '.question-votes' do
      expect(page).to have_selector '.vote-question-count', text: '0'
      find('a.question-vote-up').click

      expect(page).to have_selector '.vote-question-count', text: '1'
      find('a.question-vote-reload').click

      expect(page).to have_selector '.vote-question-count', text: '0'
    end
  end

  scenario 'question owner can not voted ', js: true do
    visit  question_path(question2)

    within '.question-votes' do
      expect(page).to have_selector '.vote-question-count', text: '0'
      find('a.question-vote-up').click

      expect(page).to have_selector '.vote-question-count', text: '0'
    end
  end
end