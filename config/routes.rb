Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :flights, only: [:show]

  resources :passengers, only: [:show, :update]
end
