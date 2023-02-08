Rails.application.routes.draw do
  # resources :posts
  # this is the reason why everyone can see all posts because it is basically in public mode
  root to: 'pages#home'
  devise_for :users

  # This method would ensure that posts are private through users
  resources :users do
    resources :posts
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
