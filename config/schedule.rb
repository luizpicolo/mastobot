require 'rack'

set :environment, ENV["RACK_ENV"]
set :output, '/var/log/cron.log'

ENV.each_key do |key|
  env key.to_sym, ENV[key]
end

every 1.hour do
  rake "toot:create"
end