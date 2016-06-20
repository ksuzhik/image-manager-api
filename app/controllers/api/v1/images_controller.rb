module Api
	module V1
		class ImagesController < BaseController
			respond_to :json
			before_action :authenticate!

			def index
				@images = current_user.images
		    render json: {result: @images}
		  end

		  def create
		  	@resource = current_user.images.create(source_file: params[:source_file])
		  	@result = @resource.resize(params[:width].to_i, params[:height].to_i)
		  	render_results
		  end

		  def update
		  	@resource = current_user.images.find_by(_id: params[:id])
		  	render_errors "Image doesn't exists" if @resource.nil?
		  	@result = @resource.resize(params[:width].to_i, params[:height].to_i)
		  	render_results
		  end

		  private 
		  	def render_results
		  		if @result
			  		render "resized_image"
			  	else
			  		render_errors @resource.errors.full_messages
			  	end
		  	end
		  	def render_errors message
			  	render json: {errors: message}, status: :unprocessable_entity 
		  	end
		end
	end
end