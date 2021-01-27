require 'rails_helper'
include ActionController::RespondWith

describe '/users', type: :request do

  include Session

  before(:each) do
      @current_user = FactoryBot.create(:member)
  end

  it 'ユーザ情報取得' do
      get "/users/#{@current_user.username}"
      expect(response.body).to eq(200)
  end

  it 'ユーザ情報更新' do
    post "/users/#{@current_user.username}", params: {  }
    expect(response.status).to eq(200)
  end

  it 'ユーザのフォロ一覧を取得'

  end
end
