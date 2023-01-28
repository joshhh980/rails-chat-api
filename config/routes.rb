Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :chatrooms, only: :index
      get :chatroom, to: "chatrooms#show"
      resources :messages, only: :create
      put "messages/read", to: "messages#read"
      resources :users
      mount ActionCable.server => "/cable"
    end
  end
end
