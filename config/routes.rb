# frozen_string_literal: true

Rails.application.routes.draw do
  post 'login', to: 'authentication#login'

  resources :users
end
