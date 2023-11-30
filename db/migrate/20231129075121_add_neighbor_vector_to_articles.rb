class AddNeighborVectorToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :embedding, :vector, limit: 1536
    # add_index :articles, :embedding, using: :hnsw, opclass: :vector_l2_ops
  end
end
