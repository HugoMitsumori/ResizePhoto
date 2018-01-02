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
      name = photo['url'].split('/').last

      photo_file = download photo['url']

      resized = resize_photo photo_file.path, name
      resized['name'] = name.split('.').first
      resized['original'] = photo['url']

      Photo.create(resized)
      photo_file.close(true)
    end
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
      resized[size] = "/#{resized_name}"
    end
    return resized
  end
end
