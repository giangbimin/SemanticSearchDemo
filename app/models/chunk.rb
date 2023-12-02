class Chunk < ApplicationRecord
  belongs_to :chunkable, polymorphic: true
  has_neighbors :embedding, normalize: true
end
