module AcceptanceHelper

  def sign_up
    visit new_user_session_path
    click_on 'Sign up'
  end

  def fill_password
    fill_in 'user[password]', with: 12345678
    fill_in 'user[password_confirmation]', with: 12345678
  end


end