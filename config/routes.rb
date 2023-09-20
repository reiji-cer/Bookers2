Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get 'home/about' => "homes#about", as: 'about'
  
  resources :users , only:[:show, :index, :edit, :update]
  post 'user/:id' => 'books#create', as: 'books_create'
  
  resources :books ,only:[ :new, :create, :edit, :update, :destroy,:index, :show, ] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

end
