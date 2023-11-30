# README
# Demo Development

## Dependencies
- ruby/rails
- postgres 15
- redis

```
redis-server
```

## Create application

```
rails new ssearch  -T -c tailwind --database=postgresql
# bundle add tailwindcss-rails
rails tailwindcss:install
rails db:migrate
```

## Create first model

```
rails generate scaffold Article title:string body:text
```

```
Rails.application.routes.draw do
  resources :articles
  root "articles#index"
end
```

```
rails db:seed
```

## Install more gem

```
gem "dotenv-rails"
```

## Get api key of open Ai use in this function

```
OPENAI_API_KEY=""
```

```
require "json"
require "net/http"

class Openai
  API_URL = "https://api.openai.com/v1/embeddings"

  def self.fetch_embeddings(input)
    headers = {
      "Authorization" => "Bearer #{ENV.fetch("OPENAI_API_KEY")}",
      "Content-Type" => "application/json"
    }
    data = {
      input: input.gsub!(/\s|"|'/, ''),
      model: "text-embedding-ada-002"
    }

    response = Net::HTTP.post(URI(API_URL), data.to_json, headers)
    JSON.parse(response.body)["data"].map { |v| v["embedding"] }[0]
  end
end
```

### test openai embedding

```
Openai.fetch_embeddings(Article.first.body)
# example result
[0.02107661, 0.0058093295, 0.008067076, -0.010111338, 0.0035742256, -0.005000681, 0.004428158, -0.013067757, -0.0020749916]
```

### Add more gem

```
gem "neighbor"
```

### Create logic search

```
rails generate neighbor:vector
rails db:migrate
```

### Migration search vector

```
class AddNeighborVectorToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :embedding, :vector, limit: 1536
  end
end
```


```
class Article < ApplicationRecord
  has_neighbors :embedding, normalize: true
end
```

### Assign Job to reindex search

```
gem 'sidekiq', '~> 7.2'
```

```
rails generate sidekiq:job reindex_search
```

```
class ReindexSearchJob
  include Sidekiq::Job

  def perform(id)
    article = Article.find(id)
    embedding = Openai.fetch_embeddings(article.body)
    article.update_attributes(embedding: embedding)
  end
end
```

```
bundle exec sidekiq
```

```
ReindexSearchJob.perform_async(Article.first.id)
```

```
nearest_item = Article.first.nearest_neighbors(:embedding, distance: "cosine").first
nearest_item.neighbor_distance
Article.first.nearest_neighbors(:embedding, distance: "cosine").first(5).map(&:id)
```

### Add Search form

```
  <%= form_with(url: articles_path, method: :get, data: {turbo_frame: "articles", turbo_action: "advance"}) do |form| %>
    <%= form.label :query, "Search anything:", class: "block mb-2" %>
    <div class="flex space-x-3">
      <%= form.text_field :query, class: "py-3 px-4 rounded border ring-0 focus:ring-4 focus:ring-orange-100 focus:shadow-none focus:border-orange-500 focus:outline-none" %>
      <%= form.submit 'Search', class: "px-4 py-3 font-medium bg-orange-300 text-neutal-900 rounded flex items-center cursor-pointer hover:bg-orange-400 focus:ring-4 ring-0 focus:ring-orange-100" %>
    </div>
  <% end %>

  <div id="articles" class="min-w-full">
    <%= render "articles", articles: @articles %>
  </div>
```

```
# _articles.html.erb
<%= turbo_frame_tag "articles" do %>
  <%= render articles %>
<% end %>
```

```
  def index
    if params[:query].present?
      @articles = Article.where("title LIKE ?", "%#{params[:query]}%")
    else
      @articles = Article.all
    end
    render partial: "articles", locals: { articles: @articles } if turbo_frame_request?
  end
```

```
# rails g stimulus search-form

import { Controller } from "@hotwired/stimulus";
// Connects to data-controller="search-form"
export default class extends Controller {
  search() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.element.requestSubmit();
    }, 200);
  }
}

```

```
<%= form_with(url: articles_path, method: :get, data: {controller: "search-form", turbo_frame: "articles", turbo_action: "advance"}) do |form| %>
...
```
