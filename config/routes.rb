Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :mechanics, only: [:show, :update] do
    # resources :rides, controller: "mechanic_rides", only: :post
    resources :rides, only: [:create] 
  # post "/mechanics/:id/rides", to: "mechanics_rides#create"
  end
end
