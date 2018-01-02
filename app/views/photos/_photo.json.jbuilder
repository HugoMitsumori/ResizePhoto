json.extract! photo, :id, :name, :original, :small, :medium, :large, :string, :created_at, :updated_at
json.url photo_url(photo, format: :json)
