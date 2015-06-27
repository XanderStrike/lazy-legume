class AddTorrentSaveLocationSetting < ActiveRecord::Migration
  def up
    execute 'insert into settings values(1, "torrent_location", "torrents/", 0, "false")'
  end
end
