Rails.application.routes.draw do

  devise_for :users

  resources :questions do
    patch :vote_up, on: :member, controller: :votes
    patch :vote_down, on: :member, controller: :votes
    resources :answers, shallow: true do
      post :best_answer, on: :member
      patch :vote_up, on: :member, controller: :votes
      patch :vote_down, on: :member, controller: :votes
    end
  end

  resources :attachments, only: [:destroy]

  root to: 'questions#index'
end