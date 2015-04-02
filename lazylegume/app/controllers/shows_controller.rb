class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]

  def index
    @shows = Show.all
  end

  def show
  end

  def new
    @show = Show.new
  end

  def edit
  end

  def create
    @show = Show.new(show_params)
    @show.save
    redirect_to @show, notice: 'Show was successfully created.'
  end

  def update
    @show.update(show_params)
    redirect_to @show, notice: 'Show was successfully updated.'
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
      params.require(:show).permit(:name)
    end
end
