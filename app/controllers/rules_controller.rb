class RulesController < ApplicationController
  before_action :set_rule_and_show, only: [:update, :destroy]

  def new
    @show = Show.find(params[:show])
    @rule = Rule.new
  end

  def create
    @rule = Rule.new(rule_params)
    @show = @rule.show
    @rule.save
    test if params[:commit] == 'Test'
  end

  def update
    @rule.update(rule_params)
    test if params[:commit] == 'Test'
  end

  def destroy
    @rule.destroy
  end

  private
    def test
      @found_eps = ScanRSS.new(@rule.feed.url).find_for_rule(@rule)
      render :test
    end

    def set_rule_and_show
      @rule = Rule.find(params[:id])
      @show = @rule.show
    end

    def rule_params
      params.require(:rule).permit(:regex, :keywords, :quality, :show_id, :feed_id)
    end
end
