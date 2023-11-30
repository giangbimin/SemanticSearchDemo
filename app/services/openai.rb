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
      input: input.gsub(/\s|"|'/, ''),
      model: "text-embedding-ada-002"
    }
    begin
      response = Net::HTTP.post(URI(API_URL), data.to_json, headers)
      return [] unless response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)["data"].map { |v| v["embedding"] }[0]
    rescue => e
      puts "An error occurred: #{e.message}"
      []
    end
  end
end
