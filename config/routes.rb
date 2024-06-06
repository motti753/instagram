require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # development環境の場合、'/letter_opener'にアクセスするとLetterOpenerWebの内容が確認きる
  mount LetterOpenerWeb::Engine, at:'/letter_opener' if Rails.env.development?

  mount Sidekiq::Web => "/sidekiq" if Rails.env.development?

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # root to: "home#index"
  root to: 'submissions#index'
  resources :submissions

  # application.html.hamlで"turbo_method: :destroy"を指定していてもnomethodErrorが出るため。
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  scope module: :apps do
    scope '/:profile_id' do
      resource :profile, only: [:show, :edit, :update]
    end
  end

  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
    resources :followers, only: [:index]
    resources :followings, only: [:index]
  end

  namespace :api do
    scope 'submissions/:submission_id' do
      resources :comments, only: [:index]
    end
  end

  namespace :api, defaults: {format: :json} do
    scope 'submissions/:submission_id' do
      resource :like, only: [:create, :destroy, :show]
      resources :comments, only: [:create]
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
