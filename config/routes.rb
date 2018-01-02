Rails.application.routes.draw do
  resources :photos do
  	collection do
  		get :fetch
  	end
  end
  #get 'photos/fetch' => 'photos#fetch'
  root :to => 'photos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
