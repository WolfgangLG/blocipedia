Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: 'users/registrations'
    }

  resources :charges, only: [:new, :create]
  resources :wikis
  root 'welcome#index'

end
