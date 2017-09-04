Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, :characters

      # post '/createCharacter/:id', to: 'characters#create'
      # patch '/editCharacter/:id', to: 'characters#update'
      # delete '/deleteCharacter/:id', to: 'characters#destroy'
      # get '/character/:id', to: 'characters#show'
      # get '/characters', to: 'characters#index'


    end
  end

end
