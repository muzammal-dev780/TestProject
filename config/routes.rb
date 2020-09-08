Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "user/registrations"}
  resources :plans 
   get 'about' => 'application#about', as: :about
   get 'contact' => 'application#contact', as: :contact
  root to: 'welcome#index'
end
