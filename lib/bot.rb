require './config/initializers/env'
require './config/initializers/mastodon'
require 'rss'
require 'open-uri'
require 'date'
require 'time'

class Bot
	def initialize(path_file)
    @client = $client
    @path_file = path_file
  end
  
  def last_date
    File.open(@path_file, "a+") do |f| 
      return Time.parse(f.readlines.map(&:chomp).last)
    end
  end

  def lasted_publications(amount)
    publictions = []
    File.open(@path_file, "a+") do |f| 
      f.readlines.reverse.each_with_index do |value, index|
        publictions << Time.parse(value)
        break if index == amount - 1
      end
    end

    publictions
  end

  def add_last_date(pub_date)
    File.open(@path_file, "a+") do |f| 
      f.puts pub_date.to_s
    end
  end

  def find_pub_date(pub_date)
    File.open(@path_file, "a+") do |f| 
      f.each do |line| 
        line.chomp!
        return true if line.include? pub_date.to_s
      end
    end
    
    return false
  end

  def feed
    open(ENV['URI_RSS']) do |rss| 
      return RSS::Parser.parse(rss)
    end  
  end

	def create_toot
    feed.items.reverse_each do |item| 
      if !find_pub_date(item.pubDate)
        add_last_date(item.pubDate)   
        @client.create_status("#{item.title} #{item.link}", params)
        return item.title
      end
    end
  end
  
  private 

  def params 
    { 
      visibility: 'public' 
    }
  end
end