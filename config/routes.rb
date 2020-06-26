Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root 'items#index'
  resources :items
  
  # resources :users, only: [:show, :edit, :update] do
  #   member do
  #     get :logout
  #     get :identification
  #     get :show2
  #   end
  #   member do
  #     get "user_item_show"
  #   end
  # end

  # resources :items do
  #   member do
  #     get :show2
  #   end
  #   resources :images
  #   resources :purchase, only: [:index] do
  #     collection do
  #       get 'index', to: 'purchase#index'
  #       post 'pay', to: 'purchase#pay'
  #       get 'done', to: 'purchase#done'
  #     end
  #   end
  # end

  # resources :categories, only: :show do
  # end

  # resources :brands, only: :show do
  # end

  # resources :sessions, only: :new do
  # end


  # resources :signup ,only: [:new] do
  #   collection do
  #     get 'step1'
  #     get 'step2'
  #     get 'step3'
  #     get 'step4' #入力おしまい
  #     get 'done' # 登録完了のページ
  #   end

  #   collection do
  #     post :create
  #   end
  # end

  # resources :card, only: [:new,:show] do
  #   collection do
  #     post 'delete', to: 'card#delete'
  #     post 'create', to: 'card#create'
  #     post 'show', to:'card#show'
  #   end
  #   member do
  #     get 'confirmation'
  #     get 'new', to: 'card#new'
  #   end
  # end 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
