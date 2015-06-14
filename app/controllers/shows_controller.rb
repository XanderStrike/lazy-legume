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
    par = show_params
    rule_params = par.delete(:rule)

    @show = Show.create(par)

    rule = Rule.build_for_show(@show, rule_params)

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
      params.require(:show).permit(:tvdb_id, :name, :poster, :name, :overview, :actors, :first_aired, :rating, :status, :airs_dayofweek, :airs_time, :genre, rule: [:quality])
    end
end
