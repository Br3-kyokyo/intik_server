module Session
  def signin (email, password)
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    post '/auth/sign_in',
         params: { email: email, password: password }.to_json, headers: headers
  end

  def signout
    headers = auth_params_in_response_header.merge({ 'CONTENT_TYPE' => 'application/json',
                                                     'ACCEPT' => 'application/json' })
    delete '/auth/sign_out', params: {}.to_json, headers: headers
  end

  def auth_params_in_response_header
    {
      'access-token' => response.headers['access-token'],
      'client' => response.headers['client'],
      'uid' => response.headers['uid'],
      'expiry' => response.headers['expiry'],
      'token-type' => response.headers['token-type']
    }
  end
end
