require 'fileutils'
class Image
	include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user, inverse_of: :images

  field :resized_variants, type: Array

  attr_accessor :source_file, :source_file_cache
  mount_uploader :source_file, SourceFileUploader

  after_create :create_resized_dir

  def resize width, height
    if width <= 0 || height <= 0
      self.errors.add(:base, "Wrong resizing parameters")
      return nil
    end
  	resizer = ImageResizer.new self.source_file.path
    resized_filename = "#{width}x#{height}_#{self.source_file.filename}"
    begin
      resizer.process width.to_i, height.to_i, "#{resized_path(resized_filename)}"
      resized_row = { 
        width: width, 
        height: height, 
        url: resized_url(resized_filename) }
      self.push(resized_variants: resized_row)
      return resized_row
    rescue => e
      logger.debug e.message
      self.errors.add(:base, "Unable to resize image")
    end
    nil
  end

  private

    def create_resized_dir
      FileUtils::mkdir_p(resized_path)
    end

    def resized_url name = ""
      "resized/#{self.id.to_s}/#{name}"
    end

    def resized_path name = ""
      "#{Rails.public_path}/#{resized_url(name)}"
    end
end