Rails.application.routes.draw do

  devise_for :users
  
  get 'welcome/home'

  get 'about' => 'welcome#about'

  get 'contact' => 'welcome#contact'

  
  resources :users, only: [:update, :show, :index]
  resources :wikis do 
    resources :collaborators, only: [:index, :create, :destroy]
  end
  resources :charges, only: [:new, :create]


  root to: 'welcome#home'
end
