require 'rails_helper'

feature 'User can register', %q{
To use the site
quest can register
} do
  given!(:user){ create(:user) }

  scenario 'quest enters valid data' do
    sign_up
    fill_in 'user[email]', with: 'testuser@test.com'
    fill_password
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully'
  end

  scenario 'quest  invalid email' do
    sign_up
    fill_in 'user[email]', with: 'testusertest.com'
    fill_password
    click_on 'Sign up'
    expect(page).to have_content 'Email is invalid'
    expect(current_path).to eq user_registration_path
  end

  scenario 'quest enters existing email' do
    sign_up
    fill_in 'user[email]', with: user.email
    fill_password
    click_on 'Sign up'
    expect(page).to have_content 'Email has already been taken'
    expect(current_path).to eq user_registration_path
  end

  scenario 'quest enters blank password' do
    sign_up
    fill_in 'user[email]', with: 'testuser@test.com'
    fill_in 'user[password]', with: ''
    fill_in 'user[password_confirmation]', with: ''
    click_on 'Sign up'
    expect(page).to have_content 'Password can\'t be blank'
    expect(current_path).to eq user_registration_path
  end

  scenario 'quest enters wrong password_confirmation' do
    sign_up
    fill_in 'user[email]', with: 'testuser@test.com'
    fill_in 'user[password]', with: '12345678'
    fill_in 'user[password_confirmation]', with: ''
    click_on 'Sign up'
    expect(page).to have_content 'Password confirmation doesn\'t match Password'
    expect(current_path).to eq user_registration_path
  end

end