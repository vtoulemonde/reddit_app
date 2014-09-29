Rails.application.routes.draw do
  root 'posts#index'
  get 'posts/index'
  
  get 'posts/search'

  resources :posts do
    member do
        get 'upvote'
        get 'downvote'
    end
    resources :comments
  end

  resources :comments do
    resources :comments
  end

end
