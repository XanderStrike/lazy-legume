class SettingsController < ApplicationController
  def index
  end

  def update
    @setting = Setting.find(params[:id])
    @setting.update_attributes(params[:setting].permit([:str, :int, :bool]))
  end
end
