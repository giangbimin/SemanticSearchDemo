class SemanticSearch
  DEFAUT_SIZE = 20
  DEFAUT_DISPLAY_SIZE = 1
  DEFAUT_DISTANCE = "cosine".freeze

  def initialize input, size = DEFAUT_SIZE, distance = DEFAUT_DISTANCE
    @input = input
    @size = size
    @distance = distance
  end

  def execute
    embedding_vector = open_ai.embed(text: @input).embedding
    Chunk.nearest_neighbors(:embedding, embedding_vector, distance: @distance)
      .first(@size)
      .map(&:chunkable)
      .uniq
      .first(DEFAUT_DISPLAY_SIZE)
  end

  def open_ai
    Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])
  end
end
