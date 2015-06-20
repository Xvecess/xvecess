Rails.application.routes.draw do

  devise_for :users

  resources :questions do
    put :vote_up, on: :member, controller: :votes
    put :vote_down, on: :member, controller: :votes
    resources :answers, shallow: true do
      post :best_answer, on: :member
      put :vote_up, on: :member, controller: :votes
      put :vote_down, on: :member, controller: :votes
      delete :destroy_vote, on: :member, controller: :votes
    end
  end

  resources :attachments, only: [:destroy]

  root to: 'questions#index'
end