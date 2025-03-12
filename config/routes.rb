# frozen_string_literal: true

Rails.application.routes.draw do
  post 'login', to: 'authentication#login'

  resources :users
  resources :dashboards, only: :index do
    get :dashboard, on: :collection
  end
  resources :departments, only: %i[index show create update destroy]
end
