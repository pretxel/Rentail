class Deposit
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :monto, :type => Integer
  field :fecha, :type => String
  field :user, :type => String
  field :extension, :type => String
  field :path_img, :type => String

  validates :monto, presence: true, numericality: true
  validates :fecha, presence: true
  validates :extension, presence: true



    validates_format_of :photo, :with => %r{\.(png|jpg|jpeg|bmp)$}i, :message => "Inserta una imagen", :on => :save, :multiline => true
	FOTOS = File.join Rails.root, 'public', 'photo_dep' 
	after_save :guardar_foto


	CONTENT_SERVER_DOMAIN_NAME = "ftp.moviesstar.biz"
	CONTENT_SERVER_FTP_LOGIN = "moviesst"
	CONTENT_SERVER_FTP_PASSWORD = "Zabvio2013#%!"
		


	def photo=(file_data)
		unless file_data.blank?
			@file_data = file_data
			self.extension = file_data.original_filename.split('.').last.downcase
			#puts file_data.original_filename
		end
	end

	def photo_filename
		File.join FOTOS, "#{user}.#{extension}"
	end

	def photo_path
		"/photo_dep/#{user}.#{extension}"
	end

	def has_photo?
		File.exists? photo_filename
	end

	private
	def guardar_foto

		# begin
		# raise 'ERROR OCURRIDO'
		# rescue 
		# logger.error "ERROR EN guardar_foto"
		# end

		
 
 
		# Net::FTP.open(CONTENT_SERVER_DOMAIN_NAME, CONTENT_SERVER_FTP_LOGIN, CONTENT_SERVER_FTP_PASSWORD) do |ftp|
		#   ftp.mkdir("/rails_apps") if !ftp.list("/").any?{|dir| dir.match(/\rails_apps$/)}
		 
		#   # create nested directory
		#   # it does not create directory tree
		#   # therefore, create "/root_level" before creating "/root_level/nested"
		#   ipad_folder = ftp.list("/rails_apps")
		#   ftp.mkdir("/rails_apps/store_images") if !ipad_folder.any?{|dir| dir.match(/\store_images$/)}
		# end

		
	

		if self.extension == "png" || self.extension == "jpg" || self.extension == "bmp"
			logger.info "IMAGEN : #{self.extension}"
			if @file_data
				FileUtils.mkdir_p FOTOS

				
				logger.info "SIZE : #{@file_data.size}"
				self.path_img =  photo_filename


				File.open(photo_filename,'wb') do |f|
					f.write(@file_data.read)
				end
				@file_data = nil
			end
		else
			logger.warn "No es una imagen"
		end

		# if Rails.env.production?
		# 	fileObject = File.new("#{photo_filename}", "r")
		# 	# upload files to nested directory
		# 	Net::FTP.open(CONTENT_SERVER_DOMAIN_NAME, CONTENT_SERVER_FTP_LOGIN, CONTENT_SERVER_FTP_PASSWORD) do |ftp|
		# 	  ftp.putbinaryfile(fileObject, "/rails_apps/store_images/#{File.basename(fileObject)}")
		# 	end
		# end
	end


end
