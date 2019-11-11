Rails.application.routes.draw do
  get 'sessions/new'
  resources :users
  root 'tasks#index'
  resources :tasks
  resources :users, only: [:new]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
    
  end
  %w( 404 422 500 503 ).each do |code|
    get code, :to => "errors#show", :code => code
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
