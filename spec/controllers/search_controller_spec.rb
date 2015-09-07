require 'rails_helper'

describe SearchController do

  describe 'GET #search' do

    it 'should call TS search' do
      expect(ThinkingSphinx).to receive(:search).with('test', classes: [Answer])
      get :search, search: {query: 'test', target: 'answers'}
    end
  end
end
