Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :products, only: [:new, :create, :index]
  root to: 'products#index'

end
