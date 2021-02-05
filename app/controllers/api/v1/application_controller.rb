class Api::V1::ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  def current_user
    @current_user ||= User.find(payload['uid'])
  end

  private

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end

  # include ActionController::HttpAuthentication::Token::ControllerMethods
  # before_action :set_session
  # def set_session
  #   uid = cookies.signed[:uid]
  #   token = cookies.[:token]

  #   authenticate_with_http_token do |token, _options|
  #     @session = REDIS.hgetall(token)
  #   end
  # end

  # def current_user
  #   User.find_by(uid: @session.uid)
  # end

  # def user_authenticated?
  #   @session.present?
  # end
end
