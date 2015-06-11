class IndexController < ApplicationController
  def index
    @recent_episodes = Episode.all.order('created_at desc').limit(12)
  end
end
