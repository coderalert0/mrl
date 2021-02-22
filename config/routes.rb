Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #

  root to: 'dashboard#show'

  resources :specialities do
    resources :download_programs
    resources :programs do
      resource :bookmark
      resource :note
    end
  end

  resources :registration
end
