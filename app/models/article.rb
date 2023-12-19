class Article < ApplicationRecord
  include Chunkable

  def content_body
    body
  end

  def chunk_separators
    [". ", "\n\n", "\n"]
  end
end