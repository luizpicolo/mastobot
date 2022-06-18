require_relative '../bot'

namespace :toot do
  desc "create toot"
  task :create do
    bot = Bot.new('db/out.txt')
    bot.create_toot
  end
end




