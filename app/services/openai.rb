require "json"
require "net/http"

class Openai
  MODEL = "text-embedding-ada-002"
  OPENAI_API = "https://api.openai.com/v1/embeddings"

  def self.fetch_embeddings(input)
    headers = {
      "Authorization" => "Bearer #{ENV.fetch("OPENAI_API_KEY")}",
      "Content-Type" => "application/json"
    }
    data = {
      input: input.gsub(/\s|"|'/, ''),
      model: MODEL
    }
    begin
      response = Net::HTTP.post(URI(OPENAI_API), data.to_json, headers)
      return [] unless response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)["data"].map { |v| v["embedding"] }[0]
    rescue => e
      puts "An error occurred: #{e.message}"
      []
    end
  end
end
