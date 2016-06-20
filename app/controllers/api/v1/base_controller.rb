class Api::V1::BaseController < ApplicationController
	protect_from_forgery with: :null_session

	def current_user
		@current_user
	end

	private

	  def authenticate!
	    authenticate_token! || render_unauthorized
	  end

	  def authenticate_token!
	    authenticate_with_http_token do |token, options|
	      @current_user = User.find_by(auth_token: token)
	      @current_user
	    end
	  end

	  def render_unauthorized
	    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
	    render json: 'Bad credentials', status: 401
	  end
end