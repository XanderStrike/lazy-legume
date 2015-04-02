class RulesController < ApplicationController
  before_action :set_rule, only: [:update, :destroy]

  def new
    @show = Show.find(params[:show])
    @rule = Rule.new
  end

  def create
    @rule = Rule.new(show_params)
    @show = @rule.show
    @rule.save
  end

  def update
    @rule.update(show_params)
  end

  def destroy
    @rule.destroy
  end

  private
    def set_rule
      @rule = Rule.find(params[:id])
      @show = @rule.show
    end

    def show_params
      params.require(:rule).permit(:regex, :show_id, :feed_id)
    end
end
