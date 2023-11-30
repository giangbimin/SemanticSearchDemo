class Article < ApplicationRecord
  has_neighbors :embedding, normalize: true
end
