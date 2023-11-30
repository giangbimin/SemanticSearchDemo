class ReindexSearchJob
  include Sidekiq::Job

  def perform(id)
    article = Article.find(id)
    embedding = Openai.fetch_embeddings(article.body)
    article.update(embedding: embedding)
  end
end
