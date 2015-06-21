require_relative 'acceptance_helper'

feature 'User can register', %q{
To use the site
quest can register
} do

  scenario 'quest enters valid data' do
    sign_up
    fill_in 'Email', with: 'testuser@test.com'
    fill_password
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully'
  end

  scenario 'quest enters blank password' do
    sign_up
    fill_in 'Email', with: 'testuser@test.com'
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''
    click_on 'Sign up'

    expect(page).to have_content 'Password can\'t be blank'
    expect(current_path).to eq user_registration_path
  end
end