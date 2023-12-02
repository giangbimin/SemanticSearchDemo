module Chunkable
  extend ActiveSupport::Concern

  included do
    has_many :chunks, as: :chunkable
  end

  CHUNK_SIZE = 300
  CHUNK_OVERLAP = 40

  def chunk!
    Langchain::Chunker::RecursiveText.new(
      content_body,
      chunk_size: 500,
      chunk_overlap: 40,
      separators: chunk_separators
    ).chunks
  end

  def clear_index!
    chunks.destroy_all
  end
end