# spec/requests/authentication_test_spec.rb

require 'rails_helper'
require 'json'
include ActionController::RespondWith

# The authentication header looks something like this:
# {"access-token"=>"abcd1dMVlvW2BT67xIAS_A", "token-type"=>"Bearer", "client"=>"LSJEVZ7Pq6DX5LXvOWMq1w", "expiry"=>"1519086891", "uid"=>"darnell@konopelski.info"}

describe 'authentication API', type: :request do
  include Session

  before(:each) do
    @current_user = FactoryBot.create(:member)
  end

  it 'サインインで201を返す' do
    signin(@current_user.uid, @current_user.password)
    expect(response).to have_http_status(:created)
  end

  it 'サインインでcsrfトークンを返す' do
    signin(@current_user.uid, @current_user.password)
    expect(csrf_token_in_response.present?).to eq(true)
  end

  it 'セッションリフレッシュでcsrfトークンを返す' do
    signin(@current_user.uid, @current_user.password)
    refresh
    expect(csrf_token_in_response.present?).to eq(true)
  end

  it 'サインイン後サインアウトでno_contentを返す' do
    signin(@current_user.uid, @current_user.password)
    signout
    expect(response).to have_http_status(:no_content)
  end

  it '誤ったCSRFトークンでサインアウトしようとするとunauthorizedを返す' do
    signin(@current_user.uid, @current_user.password)
    signout(csrf_token: 'hoge')
    p response.body
    expect(response).to have_http_status(:unauthorized)
  end
end
