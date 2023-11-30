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