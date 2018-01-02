module PhotosHelper

	FETCH_URL = "http://54.152.221.29/images.json"

	def fetch_photos
		response = RestClient.get(FETCH_URL)
		photos = JSON.parse(response)

		photos['images'].each do |photo|
			photo_file = download photo['url']

			resized = resize_photo photo_file.path
			#resized['original'] = photo_file

			# Photo.new 
			photo_file.close(true)
		end
	end

	def download (url)
		content = open(url).read
		file = Tempfile.new("temp", :encoding => 'ascii-8bit')
		file << content
		return file
	end

	def resize_photo (path)
		resized = {}

		return resized
	end
end
