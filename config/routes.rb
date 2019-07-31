Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # namespace :api, defaults: { format: :json } do
  #   namespace :v1 do
      resources :vehicles, only: [ :show, :create, :destroy ] do
        resources :locations, only: [ :create ]
      end
  #   end
  # end
  # Add a real time route
  mount ActionCable.server => '/cable'
end
