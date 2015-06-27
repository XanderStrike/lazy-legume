namespace :update do
  desc 'Finds all new shows and downloads the torrents'
  task all: :environment do
    Update.fetch_all
  end

  desc 'Fetches current info for all added TV shows'
  task metadata: :environment do
    Show.all.map(&:update_info)
  end
end
