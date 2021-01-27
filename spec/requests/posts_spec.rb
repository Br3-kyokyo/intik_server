require 'rails_helper'
include ActionController::RespondWith

describe '/posts', type: :request do
  before(:each) do
    @current_user = FactoryBot.create(:member)
  end

  it 'ポスト取得' do
  end

  it '新規ポスト' do

  end

  it 'ポストの既読ユーザー覧を取得'

  end
end