Rails.application.routes.draw do
  root 'posts#index'
  get 'posts/index'
  
  # get 'posts/:id/upvote', to 'posts#upvote'
  # get 'posts/:id/downvote', to 'posts#downvote'
  
  get 'posts/search'

  resources :posts do
    member do
        get 'upvote'
        get 'downvote'
    end
    resources :comments
  end

end
