# README

## API reference

|  path  | method | params | purpose  | headers|
| ---- | ---- | ---- | ---- | ---- |
|  users | resources | |  | |
|  posts | resources | |  | |
|  /settings/username | PUT | |  | |
|  /settings/email | PUT | |  | |
|  /settings/image | PUT | |  | |
|  /settings/profiles | PUT | |  | |
|  /:username | GET | |  | |
|  /:username/followings | GET | |  | |
|  /:username/followers | GET | |  | |
|  /:username/posts | GET | |  | |
|  /posts/:id | GET | |  | |
|  /posts/:id/read_users | GET | |  | |
|  /search?q=hoge&fuga&... | GET |  | return posts list | |
|  /posts | POST | username, body |  | |
|  /posts | PUT | post_id, body |  | |
|  /follow | POST | follow_username |  |
| -- 以下認証関連 -- |
|  /auth  | POST | email, password, password_confirmation, confirm_success_url | アカウント登録。|
|  /auth  | DELETE  |  |   アカウント削除。  |uid, access-token, client|
|  /auth  | PUT  | password, password_confirmation |    |
|  /auth/sign_in  | PUT  | email, password |    |
|  /auth/sign_out  | DELETE  | |   |uid, access-token, client | |
|  /auth/:provider | GET| | |
| /auth/:provider/callback | GET/POST | |  
| /auth/validate_token | GET | | | uid, access-token, client |
| /auth/password | POST | email, redirect_url | |
| /auth/password | PUT | password, password_confirmation | |
| /auth/password/edit | GET | reset_password_token, redirect_url | |
| /auth/confirmation | POST | email, redirect_url | |

## 認証ヘッダ




| param | description |
| ---- | ---- | 
| access-token | This serves as the user's password for each request. A hashed version of this value is stored in the database for later comparison. This value should be changed on each request. |
| client | This enables the use of multiple simultaneous sessions on different clients. (For example, a user may want to be authenticated on both their phone and their laptop at the same time.) |
| expiry | The date at which the current session will expire. This can be used by clients to invalidate expired tokens without the need for an API request. |
| uid | A unique value that is used to identify the user. This is necessary because searching the DB for users by their access token will make the API susceptible to timing attacks. |




サインアップにメール認証必要なし



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
