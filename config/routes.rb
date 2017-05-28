Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  resources :blogs, only: [:index]
  resources :posts

  get "/dashboard"  => "dashboard#index", :as => :dashboard

  namespace :account do
    resources :posts
    resources :blogs
  end
end
