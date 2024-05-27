Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

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
