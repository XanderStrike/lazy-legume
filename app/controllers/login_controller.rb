class LoginController < ApplicationController
  skip_before_filter :authenticate

  def index
    session[:authenticated] = false
    render layout: false
  end

  def login
    return render :index, layout: false unless valid_pass?
    session[:authenticated] = true
    redirect_to '/'
  end

  private

  def valid_pass?
    params[:auth][:password] == Setting.authentication.str
  end
end
