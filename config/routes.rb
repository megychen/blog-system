Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "blogs#index"
  resources :blogs, only: [:index, :show] do
    member do
      get :archives
    end
  end
  resources :posts do
    member do
      put "like", to: "posts#upvote"
    end
  end

  get "/dashboard"  => "dashboard#index", :as => :dashboard
  get "/dashboard/search" => "dashboard#search", :as => :dashboard_search

  namespace :account do
    resources :posts do
      member do
        post :draft
        post :publish
        post :hide
      end
      collection do
        post :bulk_delete
      end
    end
    resources :blogs do
      resources :categories
    end
  end
end
