require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  describe 'GET #index'
  let(:questions) { create_list(:question, 2) }
  before { get :index }
  it 'populates an array of all questions' do
    expect(assigns(:questions)).to match_array(questions)
  end


end
