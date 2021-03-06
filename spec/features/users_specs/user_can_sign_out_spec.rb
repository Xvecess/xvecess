require_relative '../acceptance_helper'

feature 'User can Logout', %q{
authenticated user can logout} do

  given(:user) { create(:user) }

  scenario 'authenticated user can logout' do
    sign_in(user)
    expect(page).to have_content 'Sign Out'
    click_on 'Sign Out'

    expect(page).to have_content 'Signed out successfully'
    visit new_user_session_path

    expect(page).to have_field 'Email'
  end
end