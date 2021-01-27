require 'rails_helper'
include ActionController::RespondWith

describe '/follows', type: :request do
  before(:each) do
    @current_user = FactoryBot.create(:member)
  end

  it '/:username ユーザのフォロー一覧取得' do
  end

  it '新規フォロー関係作成' do
  end
end
