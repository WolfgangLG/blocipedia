Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: 'users/registrations'
    }

  resources :charges, only: [:new, :create]
  get 'receipt', to: 'charges#receipt', as: 'receipt'

  resources :wikis
  root 'welcome#index'

end
