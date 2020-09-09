# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations' }

  resources :plans do
    resources :features, shallow: true
  end

  resources :users do
    resources :plans, shallow: true
  end

  resources :users do
    resources :subscriptions, shallow: true
  end

  resources :plans do
    resources :subscriptions, shallow: true
  end

  get 'about' => 'application#about', as: :about
  get 'contact' => 'application#contact', as: :contact
  root to: 'welcome#index'
end
