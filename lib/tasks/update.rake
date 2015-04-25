namespace :update do
  desc "Finds all new shows and downloads the torrents"
  task :all => :environment do
    Update.fetch_all
  end
end
