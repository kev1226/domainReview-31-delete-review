require 'sinatra'
require_relative 'controllers/reviews_controller'
require_relative 'services/jwt_service'

before do
  pass if request.path_info == '/'
  @current_user = authorize_request(request)
end

get '/' do
  { message: 'Delete Review service running' }.to_json
end

delete '/reviews/:id' do
  ReviewsController.new.delete(params, @current_user)
end
