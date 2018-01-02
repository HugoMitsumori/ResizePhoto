module PhotosHelper

	FETCH_URL = "http://54.152.221.29/images.json"

	def fetch_photos
		response = RestClient.get(FETCH_URL)
		photos = JSON.parse(response)

		photos['images'].each do |photo|
			photo_file = download photo['url']
			resized = resize photo_file
			resized['original'] = photo_file

			# Photo.new 
		end

		byebug
	end

	def download (url)

	end

	def resize_photo
	end
end
