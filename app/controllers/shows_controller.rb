class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]

  def index
    @shows = Show.order(:name)
  end

  def show
    @episodes = @show.episodes.order(:season, :ep_in_season)
  end

  def new
    @show = Show.new
  end

  def tvdb_search
    @shows = Tvdb.new.search(params[:title])
  end

  def create
    @show = Show.new(show_params)
    @show.save
    redirect_to @show, notice: 'Show was successfully created.'
  end

  def destroy
    @show.destroy
    redirect_to shows_url
  end

  private
    def set_show
      @show = Show.find(params[:id])
    end

    def show_params
      params.require(:show).permit(:tvdb_id, :name, :poster, :name, :overview, :actors, :first_aired, :rating, :status, :airs_dayofweek, :airs_time, :genre)
    end
end
