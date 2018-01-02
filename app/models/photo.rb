class Photo
  include Mongoid::Document
  field :name, type: String
  field :original, type: String
  field :small, type: String
  field :medium, type: String
  field :large, type: String
end
