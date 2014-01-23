class Deposit < ActiveRecord::Base
	
	validates_format_of :photo, :with => %r{\.(png|jpg|jpeg|bmp)$}i, :message => "Inserta una imagen", :on => :save, :multiline => true
	FOTOS = File.join Rails.root, 'public', 'photo_store' 
	after_save :guardar_foto


	def photo=(file_data)
		unless file_data.blank?
			@file_data = file_data
			self.extension = file_data.original_filename.split('.').last.downcase
			#puts file_data.original_filename
		end
	end

	def photo_filename
		File.join FOTOS, "#{id}-#{nombre}.#{extension}"
	end

	def photo_path
		"/photo_store/#{id}-#{nombre}.#{extension}"
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

		if self.extension == "png" || self.extension == "jpg" || self.extension == "bmp"
			logger.info "IMAGEN : #{self.extension}"
			if @file_data
				FileUtils.mkdir_p FOTOS
				File.open(photo_filename,'wb') do |f|
					f.write(@file_data.read)
				end
				@file_data = nil
			end
		else
			logger.warn "No es una imagen"
		end

	
		
	end
end
