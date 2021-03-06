Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'users',      to: 'users/registrations#new'
    post 'users',     to: 'users/registrations#create'
    get 'addresses',  to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root 'items#index'


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :users do
    collection do
      get "log_out"
      get "card"
      get "delivery_address"
      get "user_information"
    end
    member do
      get "add_card"
    end
  end

  resources :items do
    collection do
      get "item_purchase"
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    resources :comments, only: :create
    member do
      get 'purchase', to: 'items#purchase'
      post 'pay', to: 'items#pay'
      get 'done', to: 'items#done'
    end
  end

  resources :card, only: :create do
    collection do
      delete 'delete', to: 'card#delete'
    end
  end
end


