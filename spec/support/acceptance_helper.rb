module AcceptanceHelper
  def sign_up
    visit new_user_session_path
    click_on 'Sign up'
  end

  def fill_password
    fill_in 'Password', with: 12345678
    fill_in 'Password confirmation', with: 12345678
  end

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def mock_facebook
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
        provider: 'facebook',
        uid: '12345',
        info: {email: 'test@test.com'}
    )
  end

  def mock_twitter
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
        provider: 'twitter',
        uid: '12345'
    )
  end
end