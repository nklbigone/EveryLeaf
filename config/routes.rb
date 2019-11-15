Rails.application.routes.draw do
  resources :task_labels
  resources :labels
  get 'sessions/new'
  resources :users
  root 'tasks#index'
  resources :tasks
  resources :users, only: [:new]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
    
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
