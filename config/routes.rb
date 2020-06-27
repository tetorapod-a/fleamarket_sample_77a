Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    patch 'users/update', to: 'users/registrations#update'
    get 'addresses/edit', to: 'users/registrations#edit_address'
    patch 'addresses/update', to: 'users/registrations#update_address'
  end

  root 'items#index'
  resources :items

  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
