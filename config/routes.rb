Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # mount_devise_token_auth_for 'User', at: 'auth'

      # session control
      post '/signin', to: 'sessions#create'
      post '/refresh', to: 'sessions#refresh'
      delete '/signout', to: 'sessions#destroy'

      resources :users, only: %i[index show create update destroy], param: :uid do
        resource :post, only: %i[index show create update destroy]
        get '/follows', to: 'users#follows'
        get '/followers', to: 'users#followers'
        resources :follows, only: %i[create destroy]
      end

      # get '/:username', to: 'users#show'
      # get '/:username/follows', to: 'users#follows'
      # get '/:username/followers', to: 'users#followers'
      # get '/:username/posts', to: 'users#follows'

      resources :posts, only: %i[index show create update destroy] do
        get '/read_users', to: 'posts#read_users'
        get '/search', to: 'posts#search'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# |  users | resources | |  | |
# GET /users GET /users/:id POST /users PUT /users/:id DELETE /users/:id
# |  posts | resources | |  | |
# |  /settings/username | PUT | |  | |
# |  /settings/email | PUT | |  | |
# |  /settings/image | PUT | |  | |
# |  /settings/profiles | PUT | |  | |

# |  /:username | GET | |  | |
# |  /:username/followings | GET | |  | |
# |  /:username/followers | GET | |  | |
# |  /:username/posts | GET | |  | |

# |  /posts/:id/read_users | GET | |  | |
# |  /search?q=hoge&fuga&... | GET |  | return posts list | |
# |  /follow | POST | follow_username |  |
