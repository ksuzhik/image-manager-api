require 'rmagick'

class ImageResizer

	def initialize file
		@source = Magick::Image.read(file).first
	end

	def process width, height, resized_path
    @source.resize_to_fit!(width, height)
    @source.write(resized_path)
  end
end