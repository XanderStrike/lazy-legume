# Lazy Legume

[![Circle CI](https://circleci.com/gh/XanderStrike/lazy-legume.svg?style=svg)](https://circleci.com/gh/XanderStrike/lazy-legume)
[![Code Climate](https://codeclimate.com/github/XanderStrike/lazy-legume/badges/gpa.svg)](https://codeclimate.com/github/XanderStrike/lazy-legume)
[![Test Coverage](https://codeclimate.com/github/XanderStrike/lazy-legume/badges/coverage.svg)](https://codeclimate.com/github/XanderStrike/lazy-legume)

_Because sofa spud was taken..._

Lazy Legume is a **smart rss parser** designed for **tv show torrent feeds**. You give it a show and a preferred quality, and it downloads episodes for that show at the quality you select when it comes up in the feed. Lazy Legume remembers what episodes it's already downloaded, unlike the basic parsers included with most torrent clients, and has a lovely web based interface.

While you can run Lazy Legume on any Linux or MacOS computer, it's designed for seedboxes and dedicated servers.

### Installation

**Web Interface**

If you have Ruby installed simply clone the repository, install requirements, and set up your database:

    git clone https://github.com/XanderStrike/lazy-legume.git
    bundle install
    rake db:migrate

You can then start your server with `rails s`.

**Automated Scans**

Run `whenever` in the application directory to get a line to copy into your crontab. Type `crontab -e` to edit your crontab.

Configure your torrent client to watch the directory `lazy-legume/torrents` to automatically download them.

### Usage

Open the interface in a web browser by visiting `<server ip>:3000`. Start by adding a feed, if your tracker gives you an option, use the 'download' feed.

Next, add a show by searching for its title and selecting your preferred quality:

![New Show Page](http://imgur.com/OaPBobv.png)

You can add custom rules and view all downloaded episodes from the show page:

![Show Show Page](http://i.imgur.com/FAEsbA6.png)

### Contributing

Please do! Pull requests are always welcome.

### License

MIT
