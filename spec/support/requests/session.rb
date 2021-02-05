module Session
  def signin(uid, password)
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    post '/api/v1/signin',
         params: { uid: uid, password: password }.to_json, headers: headers
  end

  def refresh(opt = {})
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json',
                'X-CSRF-TOKEN' => opt[:csrf_token] || csrf_token_in_response }
    post '/api/v1/refresh', params: {}.to_json, headers: headers
  end

  def signout(opt = {})
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json',
                'X-CSRF-TOKEN' => opt[:csrf_token] || csrf_token_in_response }
    delete '/api/v1/signout', params: {}.to_json, headers: headers
  end

  def csrf_token_in_response
    json = JSON.parse(response.body)
    json['csrf']
  end

  # def auth_params_in_response_header
  #   {
  #     'access-token' => response.headers['access-token'],
  #     'client' => response.headers['client'],
  #     'uid' => response.headers['uid'],
  #     'expiry' => response.headers['expiry'],
  #     'token-type' => response.headers['token-type']
  #   }
  # end
end
