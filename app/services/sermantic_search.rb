class SemanticSearch
  def initialize document, size, distance = "cosine"
    @document = document
    @size = size
    @distance = distance
  end

  def search
    @document.nearest_neighbors(:embedding, distance: @distance).first(@size).map(&:content)
  end
end