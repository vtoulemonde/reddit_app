Rails.application.routes.draw do
  get 'posts/index'
  root 'posts#index'
  resources :posts

end
