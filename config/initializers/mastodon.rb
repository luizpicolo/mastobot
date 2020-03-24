require 'mastodon'

$client = Mastodon::REST::Client.new(
  base_url: ENV["BASE_URL"], 
  bearer_token: ENV["BEARER_TOKEN"]
)