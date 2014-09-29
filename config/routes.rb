Rails.application.routes.draw do
  root 'posts#index'
  get 'posts/index'
  
  get 'posts/search'

  resources :posts do
    member do
        post 'upvote'
        post 'downvote'
    end
    resources :comments
  end

  resources :comments do
    resources :comments
  end

end
