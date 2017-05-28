Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  get ":blog"  => "blogs#index"
  resources :posts

  namespace :account do
    resources :posts
  end
end
