# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations' }

  resources :plans do
    resources :features
  end

  resources :users do
    resources :plans, shallow: true
  end

  resources :users do
    resources :subscriptions, shallow: true do
      member do
        get :charge_user
      end
    end
  end

  resources :plans do
    resources :subscriptions
  end
  resources :subscriptions do
    resources :transactions, shallow: true
  end
  resources :subscriptions do
    resources :usages, shallow: true
  end

  get 'all_subscriptions', to: 'subscriptions#home'
  get 'all_subs', to: 'usages#all_subs'
  get 'all_usages', to: 'usages#home'
  root to: 'welcome#index'
  get '*path' => redirect('/')
end
