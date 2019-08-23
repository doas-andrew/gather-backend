Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # attend.rb
  resources :attends, only: [:create]

  # event.rb
  resources :events, only: [:index, :show, :create]
  
	# user.rb
  resources :users, only: [:index, :show, :create, :update]

  # friend_request.rb
  resources :friend_requests, only: [:create, :destroy]

  # friendship.rb
  resources :friendships, only: [:create, :destroy]

  # message.rb
  resources :messages, only: [:index, :create]
  patch '/messages/:id/seen', to: 'messages#seen'
  delete '/messages/mass-deletion', to: 'messages#mass_deletion'

  # session
  post '/login', to: 'sessions#login'
  get '/init-state', to: 'sessions#initState'
end
