# MastoBot

Bot to consume RSS data and make it available on the social network Mastodon

# How to use

First step is to clone the repository

    git clone https://github.com/luizpicolo/mastobot
    cd mastobot
    bundle install

Second step is to create an access key in your Mastodon account (For this step we believe that you already have an account and know how to generate an access key).

Go to `/config/initializers` and change with the requested data

    # Your instance mastodong (mastodon.social)
    ENV['BASE_URL'] = 'https://exemplo.social' 

    # Your access key
    ENV['BEARER_TOKEN'] = ''

    # Feed for consumption
    ENV['URI_RSS'] = 'https://feed.example'

To test run in the terminal

    rake toot:create

If everything went well you will have a news from the feed published in your instance.

Each call to the task publishes only one news item. So, you will have to create a Cron task for automatic publication in your instance.

# License

This software uses the same license as Mastodon
https://github.com/luizpicolo/mastobot/blob/master/LICENSE