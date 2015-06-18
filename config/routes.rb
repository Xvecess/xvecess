Rails.application.routes.draw do

  devise_for :users

  resources :questions do
    resources :answers, shallow: true do
      post 'best_answer', on: :member
      put 'answer_vote_up', on: :member
      put 'answer_vote_down', on: :member
    end
  end

  resources :attachments, only: [:destroy]

  root to: 'questions#index'
end