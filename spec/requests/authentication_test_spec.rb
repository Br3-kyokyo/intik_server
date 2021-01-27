# spec/requests/authentication_test_spec.rb

require 'rails_helper'
include ActionController::RespondWith

# The authentication header looks something like this:
# {"access-token"=>"abcd1dMVlvW2BT67xIAS_A", "token-type"=>"Bearer", "client"=>"LSJEVZ7Pq6DX5LXvOWMq1w", "expiry"=>"1519086891", "uid"=>"darnell@konopelski.info"}

describe 'authentication API', type: :request do
  include Session

  before(:each) do
    @current_user = FactoryBot.create(:member)
  end

  it 'サインアップで200を返す' do
    post '/auth',
         params: { email: 'test@example.com', password: 'password', password_confirmation: 'password' }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response.status).to eq(200)
  end

  it 'サインインで200を返す' do
    signin(@current_user.email, @current_user.password)
    expect(response.status).to eq(200)
  end

  it 'サインインするとアクセストークンを返す' do
    signin(@current_user.email, @current_user.password)
    expect(response.has_header?('access-token')).to eq(true)
  end

  it 'サインイン後サインアウトで200を返す' do
    signin(@current_user.email, @current_user.password)
    signout
    expect(response.status).to eq(200)
  end

  # なぜかうまく通らない　
  # /Users/br3-kyokyo/gitreps/intik/api/vendor/bundle/ruby/2.7.0/gems/devise_token_auth-1.1.3/app/models/devise_token_auth/concerns/user.rb:124 DeviseTokenAuth::Concerns::User#token_is_current?:
  # で一時停止して、少し待ってからcontinueすると404を返す。即座にcontinueすると200を返す。なぜ？
  #
  # it '間違ったトークンではサインアウトしようとすると401を返す' do
  #   signin
  #   signout_with_wrong_token
  #   expect(response.status).to eq(401)
  # end

  def signout_with_wrong_token
    headers = auth_params_in_response_header.merge({ 'access-token' => '123', 'CONTENT_TYPE' => 'application/json',
                                                     'ACCEPT' => 'application/json' })
    p headers
    delete '/auth/sign_out', params: {}.to_json, headers: headers
  end
end
