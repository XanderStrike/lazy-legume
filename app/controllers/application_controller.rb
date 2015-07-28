class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate

  private

  def authenticate
    session[:require_auth] = Setting.authentication.bool if session[:require_auth].nil?
    redirect_to login_path if !session[:authenticated] && session[:require_auth]
  end
end
