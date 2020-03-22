require 'Mastodon'
require 'rss'
require 'open-uri'
require 'date'
require 'time'

BASE_URL: 'https://newsbots.eu'
BEARER_TOKEN: 'hYPBsvDmofQnsKse4otEOPpRU7wrX5zUhrONyBnXG1g'
URI_RSS: 'https://rss.tecmundo.com.br/feed'

client = Mastodon::REST::Client.new(
  base_url: BASE_URL, 
  bearer_token: BEARER_TOKEN 
)

params = { 
  visibility: 'public' 
}

File.open("out.txt", "a+") do |f|
  last_date = Time.parse(f.readlines.map(&:chomp).last)
  
  open(URI_RSS) do |rss|
    feed = RSS::Parser.parse(rss)

    feed.items.reverse_each do |item| 
      if item.pubDate > last_date     
        f.puts item.pubDate
        client.create_status("#{item.title} #{item.link}", params)
      end
    end
  end

  f.close
end


