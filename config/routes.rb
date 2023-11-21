Rails.application.routes.draw do
  root "user_sessions#new"
  post "/", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  resources :rooms, only: %i[index]
end
