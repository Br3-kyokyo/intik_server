require 'rails_helper'
include ActionController::RespondWith

describe '/posts', type: :request do
  before(:each) do
    @current_user = FactoryBot.create(:member)
  end

  it 'ポスト検索' do
  end
end
