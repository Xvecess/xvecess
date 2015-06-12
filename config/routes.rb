Rails.application.routes.draw do

  devise_for :users

  resources :questions do
    resources :answers, shallow: true do
        post 'correct', on: :member
    end
  end

  root to: 'questions#index'
end
