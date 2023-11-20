Rails.application.routes.draw do
  root "user_sessions#new"
  post "/", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  resources :messages, only: %i[index] do
    collection do
      get "api"
    end
  end
end
