require 'rails_helper'

RSpec.describe QuestionsController do
  describe '#show' do
    before do
      sign_in_as
    end

    it 'assigns the Question' do
      question = instance_double('Question', :question)
      allow(Question).to receive(:find).with('123').and_return(question)

      get :show, params: { id: '123' }

      expect(assigns(:question)).to eq(question)
    end
  end

  describe '#new' do
    before do
      sign_in_as
    end

    it 'assigns a new Question' do
      question = instance_double('Question', :question)
      allow(Question).to receive(:new).and_return(question)

      get :new

      expect(assigns(:question)).to eq(question)
    end
  end

  describe '#create' do
    let(:question) { instance_double('Question', :question, save: true) }
    let(:current_user) { instance_double('User') }

    before do
      allow(Question).to receive(:new).and_return(question)
      sign_in_as(current_user)
    end

    it 'builds a new Question with the params' do
      post :create, params: { question: { title: 'Title', body: 'Body' } }

      expect(Question).to have_received(:new).with(hash_including(title: 'Title', body: 'Body', author: current_user))
    end

    it 'saves the question' do
      post :create, params: { question: { title: 'Title', body: 'Body' } }

      expect(question).to have_received(:save)
    end

    context 'when the question is saved successfully' do
      before do
        allow(question).to receive(:save).and_return(true)
      end

      it 'redirects to the question page' do
        post :create, params: { question: { title: 'Title', body: 'Body' } }

        expect(response).to redirect_to(question_path(question))
      end
    end

    context 'when the question is not saved successfully' do
      before do
        allow(question).to receive(:save).and_return(false)
      end

      it 'renders the new question page again' do
        post :create, params: { question: { title: 'Title', body: 'Body' } }

        expect(response).to render_template(:new)
      end
    end
  end
end
