# README

## API reference

<!-- |  path  | method | params | purpose  | headers|
| ---- | ---- | ---- | ---- | ---- |
|  users | resources(uid) | |  | |
|  posts | resources | |  | |
|  /:uid | GET | |  | |
|  /:uid/followings | GET | |  | |
|  /:uid/followers | GET | |  | |
|  /:uid/posts | GET | |  | |
|  /posts/:id/read_users | GET | |  | |
|  /search?q=hoge&fuga&... | GET |  | return posts list | |
|  /follow | POST | follow_username |  |
| -- 以下認証関連 -- |
|  /signin  | POST | uid, password | |
|  /refresh  | POST | | |
|  /signout  | POST | | | -->

                    Prefix Verb   URI Pattern                                    
            api_v1_signin POST   /api/v1/signin(.:format)                        
            api_v1_refresh POST   /api/v1/refresh(.:format)                    
            api_v1_signout DELETE /api/v1/signout(.:format)                      
          api_v1_user_post GET    /api/v1/users/:user_uid/post(.:format)         
                          PATCH  /api/v1/users/:user_uid/post(.:format)          
                          PUT    /api/v1/users/:user_uid/post(.:format)          
                          DELETE /api/v1/users/:user_uid/post(.:format)          
                          POST   /api/v1/users/:user_uid/post(.:format)          
      api_v1_user_follows GET    /api/v1/users/:user_uid/follows(.:format)       
    api_v1_user_followers GET    /api/v1/users/:user_uid/followers(.:format)     
                          POST   /api/v1/users/:user_uid/follows(.:format)       
        api_v1_user_follow DELETE /api/v1/users/:user_uid/follows/:id(.:format)  
              api_v1_users GET    /api/v1/users(.:format)                        
                          POST   /api/v1/users(.:format)                         
              api_v1_user GET    /api/v1/users/:uid(.:format)                    
                          PATCH  /api/v1/users/:uid(.:format)                    
                          PUT    /api/v1/users/:uid(.:format)                    
                          DELETE /api/v1/users/:uid(.:format)                    
    api_v1_post_read_users GET    /api/v1/posts/:post_id/read_users(.:format)    
        api_v1_post_search GET    /api/v1/posts/:post_id/search(.:format)        
              api_v1_posts GET    /api/v1/posts(.:format)                        
                          POST   /api/v1/posts(.:format)                         
              api_v1_post GET    /api/v1/posts/:id(.:format)                     
                          PATCH  /api/v1/posts/:id(.:format)                     
                          PUT    /api/v1/posts/:id(.:format)                     
                          DELETE /api/v1/posts/:id(.:format)                     


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
