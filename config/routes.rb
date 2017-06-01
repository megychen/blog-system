Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  resources :blogs, only: [:index, :show] do
    member do
      get :archives
      get :about
    end
  end
  resources :posts do
    member do
      put "like", to: "posts#upvote"
    end
  end

  get "/dashboard"  => "dashboard#index", :as => :dashboard
  get "/dashboard/search" => "dashboard#search", :as => :dashboard_search
  get "/admin"  => "admin#index", :as => :admin

  namespace :admin do
    resources :blogs
    resources :posts
    resources :users do
      member do
        post :set_admin
      end
    end
  end

  namespace :account do
    resources :posts do
      member do
        post :draft
        post :publish
        post :hide
      end
    end
    resources :blogs do
      resources :categories
    end
  end
end
