json.extract! photo, :id, :small, :medium, :large, :created_at, :updated_at
json.url photo_url(photo, format: :json)
