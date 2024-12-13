Rails.application.routes.draw do

 scope module: :public do
  devise_for :users,
  controllers: { registrations: 'registrations' }

  root to: "homes#top"
  get "/homes/about" => "homes#about", as: "about"

  resources :users, only: [:show, :edit, :update, :destroy]
  resources :posts, only: [:new, :create, :edit, :index, :show, :update, :destroy] do
  resource :good, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
  end
  


  devise_scope :user do
  post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
  get "search" => "searches#search"
end
  



  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end


end




