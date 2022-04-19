Rails.application.routes.draw do
  root 'products#index'
  
  resources :products, only: [:create, :show] do
    resources :product_steps, only: [:show, :update]
  end

end
