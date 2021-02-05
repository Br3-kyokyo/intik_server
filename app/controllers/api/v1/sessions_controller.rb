class Api::V1::SessionsController < Api::V1::ApplicationController
  before_action :authorize_refresh_by_access_cookie!, only: [:refresh]
  before_action :authorize_by_access_cookie!, only: [:destroy]

  def create
    user = User.find_by(uid: params[:uid])
    if user&.authenticate(params[:password])

      payload = { uid: user.uid }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login
      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)

      render json: { csrf: tokens[:csrf] }, status: :created
    else
      render json: 'Invalid email or password', status: :unauthorized
    end
  end

  def refresh
    session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)
    tokens  = session.refresh_by_access_payload
    response.set_cookie(JWTSessions.access_cookie,
                        value: tokens[:access],
                        httponly: true,
                        secure: Rails.env.production?)

    render json: { csrf: tokens[:csrf] }, status: :ok
  end

  def destroy
    session = JWTSessions::Session.new(refresh_by_access_allowed: true, payload: payload)
    session.flush_by_access_payload
    render json: {}, status: :no_content
  end

  # def destroy
  #   if user_authenticated?
  #     REDIS.delete(@session.token)
  #     render json: {}, status: :no_content
  #   else
  #     render json: {}, status: :unauthorized
  #   end
  # end

  # def create
  # 認証に成功したらRedisにセッションを登録
  # user = User.find_by(uid: params[:uid])
  # if user && user.authenticate(params[:password])

  #   token = SecureRandom.hex(64)
  #   REDIS.mapped_hmset(
  #     token,
  #     'uid' => user.uid
  #   )
  #   REDIS.expire(token, Settings.session.timeout)
  #   # response.set_header('access-token', token)
  #   cookie.permanent.signed[:uid] = user.uid
  #   cookie.permanent[:access_token] = token
  #   render json: { csrf:  }, status: :created
  # else
  #   render json: {}, status: :unauthorized
  # end
  # end
end
