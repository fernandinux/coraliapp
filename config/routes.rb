Rails.application.routes.draw do
  resources :estadisticas
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        token_validations: 'overrides/token_validations',
      }
      resources :estadisticas
      resources :credentials
      resources :events, only: [:index]
      resources :users
      get "credentials/code/:code", to: "credentials#verifycode"
      get "users/:dni/credentials", to: "users#verifydni"
      get "users/:id/image-profile", to: "users#getImage"
      patch "users/:id/image-profile", to: "users#imageprofile"
    end
  end
end
