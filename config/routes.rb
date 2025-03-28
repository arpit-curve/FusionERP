# frozen_string_literal: true

Rails.application.routes.draw do
  post 'login', to: 'authentication#login'
  post 'logout', to: 'authentication#logout'

  resources :users
  resources :dashboards, only: :index do
    get :dashboard, on: :collection
  end
  resources :departments, only: %i[index show create update destroy] do
    resources :designations
  end
  resources :roles
end
