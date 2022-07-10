require 'rails_helper'

RSpec.feature 'User adds a question' do
  scenario 'User adds a question' do
    given_i_am_logged_in
    when_i_create_a_new_question
    then_i_should_see_my_question
  end

  def given_i_am_logged_in
    given_i_have_an_account
    visit '/'
    fill_in 'Email', with: 'me@example.com'
    fill_in 'Password', with: 'password1'
    click_on 'Log in'
  end

  def given_i_have_an_account
    User.create!(
      name: 'fredflintstone',
      email: 'me@example.com',
      password: 'password1',
      password_confirmation: 'password1'
    )
  end

  def when_i_create_a_new_question
    click_on 'New question'
    fill_in 'Title', with: "What's the best biscuit?"
    fill_in 'Body', with: <<~EOF
      I reckon it's Plain Chocolate Digestives, but my friend says Hobnobs. Who's right?
    EOF
    click_on 'Create Question'
  end

  def then_i_should_see_my_question
    expect(body).to have_content("What's the best biscuit?")
    expect(body).to have_content("By fredflintstone")
    expect(body).to have_content("I reckon it's Plain Chocolate Digestives")
  end
end
