Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end

  authenticated :user do
    root :to => "dashboard#show", as: :authenticated_root
  end

  root :to => 'registration#show', id: 'profile'

  resources :specialities do
    resources :download_programs
    resources :programs do
      resource :bookmark
      resource :note
    end
  end

  resource :contact
  resources :registration
  resources :users

  get '/sitemap.xml', to: 'sitemap#show'
end
