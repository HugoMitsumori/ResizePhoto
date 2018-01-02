class Photo
  include Mongoid::Document
  field :small, type: String
  field :medium, type: String
  field :large, type: String
end
