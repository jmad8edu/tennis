Rails.application.routes.draw do
  resources :matches
  resources :users

  root 'static_pages#home'
  
  get   'mark_read'                => 'notifications#mark_read'
  get    'notifications'   	        => 'notifications#index'
  get 	 'about'   							    => 'static_pages#about'
  get 	 'contact' 							    => 'static_pages#contact'
  get    'signup'  							    => 'users#new'
  get    'login'   							    => 'sessions#new'
  post   'login'   							    => 'sessions#create'
  delete 'logout'  							    => 'sessions#destroy'
  post   'respond'                  => 'matches#respond'
end
