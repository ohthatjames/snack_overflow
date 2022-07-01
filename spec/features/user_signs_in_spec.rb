require 'rails_helper'

RSpec.feature 'User registration and sign-in' do
  scenario 'User registers' do
    when_i_visit_the_home_page
    and_i_fill_in_the_registration_form
    then_i_should_have_signed_up_successfully
    and_i_should_see_the_questions_page
  end

  scenario 'Existing user logs in' do
    given_i_have_an_account
    when_i_visit_the_home_page
    and_i_enter_my_login_credentials
    and_i_should_see_the_questions_page
  end

  def given_i_have_an_account
    User.create!(
      email: 'me@example.com',
      password: 'password1',
      password_confirmation: 'password1'
    )
  end

  def when_i_visit_the_home_page
    visit '/'
  end

  def and_i_fill_in_the_registration_form
    click_on 'Sign up'
    fill_in 'Email', with: 'me@example.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'
    click_on 'Sign up'
  end

  def and_i_enter_my_login_credentials
    fill_in 'Email', with: 'me@example.com'
    fill_in 'Password', with: 'password1'
    click_on 'Log in'
  end

  def then_i_should_have_signed_up_successfully
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  def and_i_should_see_the_questions_page
    expect(page).to have_content('Current Questions')
  end
end