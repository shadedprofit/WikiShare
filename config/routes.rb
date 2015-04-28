Rails.application.routes.draw do
  devise_for :users
  
  get 'welcome/home'

  get 'about' => 'welcome#about'

  get 'contact' => 'welcome#contact'

  
  # resources :users, only: [:update, :show]

  root to: 'welcome#home'
end
