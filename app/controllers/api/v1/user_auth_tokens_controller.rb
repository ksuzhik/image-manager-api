class Api::V1::UserAuthTokensController < Api::V1::BaseController
   
  def create
  	@user = User.new
  	@user.save
    render json: @user.auth_token, status: 200
  end
end
