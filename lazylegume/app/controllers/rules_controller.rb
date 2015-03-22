class RulesController < ApplicationController
  before_action :set_rule, only: [:update, :destroy]

    # GET /rules/new
  def new
    @show = Show.find(params[:show])
    @rule = Rule.new
  end

  # POST /rules
  # POST /rules.json
  def create
    @rule = Rule.new(show_params)
    @show = @rule.show
    @rule.save
  end

  # PATCH/PUT /rules/1
  # PATCH/PUT /rules/1.json
  def update
    @rule.update(show_params)
  end

  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    @rule.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule
      @rule = Rule.find(params[:id])
      @show = @rule.show
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def show_params
      params.require(:rule).permit(:regex, :show_id)
    end
end
