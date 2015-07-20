require_relative '../acceptance_helper'

feature 'Sign in with oauth providers' do

  background { OmniAuth.config.test_mode = true }

  scenario 'sign in with  provider facebook, provider  given email' do
    mock_facebook
    visit new_user_session_path
    click_on 'Sign in with Facebook'

    expect(page).to have_content 'Successfully authenticated from Facebook account'
  end

  scenario 'sign in with  provider facebook' do
    mock_twitter
    visit new_user_session_path
    click_on 'Sign in with Twitter'
    fill_in 'auth[info][email]', with: 'test@test.com'
    click_on 'Confirm email'

    open_email 'test@test.com'
    current_email.click_link 'Confirm my account'
    clear_emails

    expect(page).to have_content 'Your email address has been successfully confirmed'

    click_on 'Sign in with Twitter'

    expect(page).to have_content 'Successfully authenticated from Twitter account'
  end
end
