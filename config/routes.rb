Rails.application.routes.draw do
  root 'products#index'
  
  resources :products, only: [:create, :show] do
    resources :product_steps, only: [:show, :update]
  end

  # custom para usar cells
  post 'products/:product_id/product_steps/:step' => 'product_steps#update'

end
