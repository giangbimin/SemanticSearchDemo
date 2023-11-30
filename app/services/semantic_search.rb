class SemanticSearch
  def initialize input, size = 5, distance = "cosine"
    @input = input
    @size = size
    @distance = distance
  end

  def execute
    embedding_vector = Openai.fetch_embeddings(@input)
    Article.nearest_neighbors(:embedding,  embedding_vector, distance: @distance).first(10)
  end
end