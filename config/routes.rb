Rails.application.routes.draw do
  get 'welcome/home'

  get 'about' => 'welcome#about'

  get 'contact' => 'welcome#contact'

  root to: 'welcome#home'
end
