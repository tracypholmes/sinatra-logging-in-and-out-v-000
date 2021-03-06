require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    # Do I really need password here??

    @user = User.find_by(username: params[:username])
    if @user.nil?
      erb :error
    else
      session[:user_id] = @user.id
      redirect '/account'
    end
  end

  # Study more on how these next two work. VERY IMPORTANT

  get '/account' do
    @user = User.find_by_id(session[:user_id])
    if @user.nil?
      erb :error
    else
      erb :account
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
