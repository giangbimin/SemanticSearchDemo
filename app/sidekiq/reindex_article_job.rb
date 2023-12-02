class ReindexArticleJob
  include Sidekiq::Job

  def perform(id)
    @article = Article.find(id)
    @article.clear_index!
    execute
  end

  private

  def execute
    chunks = @article.chunks
    @article.chunk!.each do |chunk|
      content = chunk.text
      embedding = embedding(content)
      chunks.create(content: content, embedding: embedding)
    end
  end

  def embedding(chunk_text)
    open_ai.embed(text: chunk_text).embedding
  end

  def open_ai
    Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])
  end
end
