# spec/requests/authentication_test_spec.rb

require 'rails_helper'
include ActionController::RespondWith

# The authentication header looks something like this:
# {"access-token"=>"abcd1dMVlvW2BT67xIAS_A", "token-type"=>"Bearer", "client"=>"LSJEVZ7Pq6DX5LXvOWMq1w", "expiry"=>"1519086891", "uid"=>"darnell@konopelski.info"}


# 認証APIがうまく動いていることを確認するには
# - アカウントを作るとcreatedが返ってくること
# - アカウントを消すとdestroyedが返ってくること
# - サインインするとトークンが得られること
# - サインインすると200が返ってくること
# - 受け取ったトークンで個人情報にアクセスできること
# - 間違ったトークンでは個人情報にアクセスできないこと
# - サインインしていない場合個人情報にアクセスできないこと




describe '認証API: ', type: :request do
  
  before(:each) do
    @current_user = FactoryBot.create(:member)
    @client = FactoryBot.create(:client)
  end

  context 'ログインしない場合' do 
    it "401 Unauthorized エラーを返すこと" do
        get client_path(@client)
        expect(response.status).to eq(401)
    end
  end

  context 'ログインする場合' do 

    before do
        login
    end

    it '存在するユーザと正しいパスワードでアクセストークンを得られること' do
        # puts "#{response.headers.inspect}"
        # puts "#{response.body.inspect}"
        expect(response.has_header?('access-token')).to eq(true)
    end

    it '200を返すこと' do
        expect(response.status).to eq(200)
    end

    it 'トークンを用いて、マイページ(restricted page)にアクセスできること' do
        auth_params = get_auth_params_from_login_response_headers(response)
        new_client = FactoryBot.create(:client)
        get find_client_by_name_path(new_client.name), headers: auth_params
        expect(response).to have_http_status(:success)
    end

    it '間違ったトークンを用いて、マイページにアクセスできないこと' do
        auth_params = get_auth_params_from_login_response_headers(response).tap do |h|
            h.each do |k, _v|
                if k == 'access-token'
                    h[k] = '123'
                end 
            end
        end
        new_client = FactoryBot.create(:client)
        get find_client_by_name_path(new_client.name), headers: auth_params
        expect(response).not_to have_http_status(:success)
    end
  end

  RSpec.shared_examples 'use authentication tokens of different ages' do |token_age, http_status|
    let(:vary_authentication_age) { token_age }

    it 'uses the given parameter' do
      expect(vary_authentication_age(token_age)).to have_http_status(http_status)
    end

    def vary_authentication_age(token_age)
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      new_client = FactoryBot.create(:client)
      get find_client_by_name_path(new_client.name), headers: auth_params
      expect(response).to have_http_status(:success)

      allow(Time).to receive(:now).and_return(Time.now + token_age)

      get find_client_by_name_path(new_client.name), headers: auth_params
      response
    end
  end

  context 'test access tokens of varying ages' do
    include_examples 'use authentication tokens of different ages', 2.days, :success
    include_examples 'use authentication tokens of different ages', 5.years, :unauthorized
  end

  def login
    post user_session_path, params:  { email: @current_user.email, password: 'password' }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    auth_params = {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token-type' => token_type
    }
    auth_params
  end
end