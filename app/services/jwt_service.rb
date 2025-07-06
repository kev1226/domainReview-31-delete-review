require_relative '../utils/jwt_helper'

def authorize_request(request)
  header = request.env['HTTP_AUTHORIZATION']
  halt 401, { error: 'Token requerido' }.to_json if header.nil?

  token = header.split(' ').last
  begin
    JWTHelper.decode_token(token)
  rescue => e
    halt 403, { error: e.message }.to_json
  end
end
