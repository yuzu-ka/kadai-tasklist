Rails.application.routes.draw do
    root to: 'users#index'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
    resources :tasks, only: [:show, :create, :edit, :destroy, :update]
    resources :users, only: [:index, :new, :create, :show]
end