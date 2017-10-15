Rails.application.routes.draw do
  resources :trees, only: [:index, :update] do
    post :create_child
  end
end
