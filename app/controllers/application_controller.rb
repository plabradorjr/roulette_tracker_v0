class ApplicationController < Sinatra::Base

configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "surgiapp_secret"
  end


  get '/' do
    if logged_in?
      @note = Roulette.all
      erb :'roulettes/show_all_notes'
    else
      erb :index
    end    
  end
 

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def valid_login?(str)
      return true if (/^\w*$/.match(str))
      return false
    end

  end

end 