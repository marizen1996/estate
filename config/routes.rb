Rails.application.routes.draw do

  devise_for :users, 
    controllers: { registrations: 'registrations' }
    
  root to: "homes#top"
  get "/homes/about" => "homes#about", as: "about"

  resources :posts, only: [:new, :create, :edit, :index, :show, :destroy] do
    resource :good, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  devise_scope :user do
   post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
   end

  resources :users, only: [:show, :edit, :update, :destroy]
  

  
end





