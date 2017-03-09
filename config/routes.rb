# frozen_string_literal: true
Rails.application.routes.draw do
  root to: 'homes#index'
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#signup', as: 'signup'
  get 'signin', to: 'sessions#new', as: 'signin'
  delete 'signout', to: 'sessions#destroy', as: 'signout'
  get 'dashboard', to: 'users#show', as: 'dashboard'
  resources :users
  get 'links/:id' => 'links#edit', as: 'edit'
  post 'links/:id' => 'links#update'
  resources :links, only: [:create, :destroy, :update]
  resources :generals
  get '/:path' => 'links#redirector'
end
