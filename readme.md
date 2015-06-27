# Lazy Legume

[![Circle CI](https://circleci.com/gh/XanderStrike/lazy-legume.svg?style=svg)](https://circleci.com/gh/XanderStrike/lazy-legume)
[![Code Climate](https://codeclimate.com/github/XanderStrike/lazy-legume/badges/gpa.svg)](https://codeclimate.com/github/XanderStrike/lazy-legume)
[![Test Coverage](https://codeclimate.com/github/XanderStrike/lazy-legume/badges/coverage.svg)](https://codeclimate.com/github/XanderStrike/lazy-legume)

_Because sofa spud was taken..._

Lazy Legume is a **smart rss parser** designed for **tv show torrent feeds**. You give it a show and a preferred quality, and it downloads episodes for that show at the quality you select when it comes up in the feed. Lazy Legume remembers what episodes it's already downloaded, unlike the basic parsers included with most torrent clients, and has a lovely web based interface.

While you can run Lazy Legume on any Linux or MacOS computer, it's designed for seedboxes and dedicated servers.

[Here are some snazzy screenshots](http://imgur.com/a/MJ0u3) that describe the features in greater detail.

### Installation

**Web Interface**

With Ruby installed simply clone the repository, install requirements, and set up your database:

    git clone https://github.com/XanderStrike/lazy-legume.git
    bundle install
    rake db:migrate db:seed

You can then start your server with `rails s`. Optionally change the port using `rails s -p <port number>`.

**Automated Scans**

Manual scans of the feeds can be performed with `rake scan:all`, but this is not recommended.

Run `whenever` in the application directory to get a line to copy into your crontab. Type `crontab -e` to edit your crontab. The default frequency is every 5 minutes, but you can modify `config/schedule.rb` to suit your needs.

Configure your torrent client to watch the directory `lazy-legume/torrents` to automatically download them, or you can change the default torrent location within the Lazy Legume web interface.

### Usage

Open the interface in a web browser by visiting `<server ip>:3000`. Start by adding a feed, if your tracker gives you an option, use the 'download' feed.

Next, add a show by searching for its title and selecting your preferred quality.

You can add custom rules and view all downloaded episodes from the show page:

### Contributing

Fork the repository, open a pull request.

Ensure all work is tested with `rspec`, linted with `rubocop`, and achieves a 4.0 on CodeClimate with 100% test coverage.

### License

MIT

Favicon: Potato by Yi Chen from the [Noun Project](https://thenounproject.com/search/?q=potato&i=61071)
