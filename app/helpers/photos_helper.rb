module PhotosHelper

  FETCH_URL = "http://54.152.221.29/images.json"
  SIZES = {
    "small" => [320, 240],
    "medium" => [384, 288],
    "large" => [640, 480]
  }


  # gets photos from URL and add its resized urls to database
  def fetch_photos
    response = RestClient.get(FETCH_URL)
    photos = JSON.parse(response)

    photos['images'].each do |photo|
     
      begin 
        Photo.find photo['url']

      # Process url only if not in database
      rescue Mongoid::Errors::DocumentNotFound => error
        name = photo['url'].split('/').last

        photo_file = download photo['url']

        register = resize_photo( photo_file.path, name )
        register['_id'] = photo['url']

        Photo.create(register)
        photo_file.close(true)
      end
    end
    generate_json
  end

  # downloads content from url and returns it as a temp file
  def download (url)
    content = open(url).read
    file = Tempfile.new("temp", :encoding => 'ascii-8bit')
    file << content
    return file
  end

  # generate all sizes for given photo
  def resize_photo (path, name)
    resized = {}
    SIZES.each do |size, dimensions|
      resized_name = "#{size}-#{name}"
      image = MiniMagick::Image.open path
      image.resize("%dx%d" % dimensions)
      image.format name.split('.').last
      image.write "public/#{resized_name}"
      resized[size] = "#{request.original_url}#{resized_name}"
    end
    return resized
  end

  # puts database entries in json file
  def generate_json
    file = File.new("public/images.json", "w+")
    file.write JSON.pretty_generate Photo.all.as_json
    file.close
  end
end
