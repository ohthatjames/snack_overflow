require 'rails_helper'

RSpec.feature 'User adds a question' do
  scenario 'User adds a question' do
    given_i_am_logged_in
    when_i_create_a_new_question
    then_i_should_see_my_question
  end

  scenario 'User answers a question' do
    given_i_am_logged_in
    and_there_is_a_question
    when_i_view_a_question
    and_i_answer_the_question
    then_i_should_see_my_answer
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

  def and_there_is_a_question
    @question = Question.create!(
      title: 'Cakes',
      body: 'Are cakes a snack?',
      author: User.create!(
        name: 'asker',
        email: 'asker@example.com',
        password: 'password1',
        password_confirmation: 'password1'
      )
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

  def when_i_view_a_question
    visit question_path(@question)
  end

  def and_i_answer_the_question
    fill_in 'Add your answer', with: 'Yes, cakes are a snack'
    click_on 'Post Answer'
  end

  def then_i_should_see_my_answer
    expect(body).to have_content('Yes, cakes are a snack')
  end
end
