class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

  def authenticate_user
    client_id = ENV['GITHUB_CLIENT_ID']
    state = ENV['GITHUB_CLIENT_SECRET']
    redirect_uri = CGI.escape("http://localhost:3000/auth")
    redirect_to "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}" unless logged_in?
  
  end

  def logged_in?
    !!session[:token]
  end
end