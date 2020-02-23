class UsersController < ApplicationController


  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/'
    end
  end

  post '/login' do
    downcase_name = params[:username].downcase
    user = User.find_by(:username => downcase_name)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/"
    else
      @error_message = "Sorry, the username or password did not match our system."
      erb :"users/error_message"
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/'
    else
      redirect to '/'
    end
  end


  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/'
    end
  end

  post '/signup' do
    downcase_name = params[:username].downcase
    # downcase_email = params[:email].downcase
    username_taken = User.find_by(:username => downcase_name)
    # email_taken = User.find_by(:email => downcase_email)
    if params[:invite_code] != "PinkElephant$777"
        @error_message = "Invite code not valid."
        erb :'/users/error_message'
    elsif username_taken
        @error_message = "Sorry, that username is already taken."
        erb :'/users/error_message'
    # elsif email_taken
    #     @error_message = "Sorry, that email is already taken."
    #     erb :'/users/error_message'
    elsif !valid_login?(params[:username])
        @error_message = "Sorry, special characters are not allowed in username. Choose only words, underscore and numbers. Please try again."
        erb :'/users/error_message'
    elsif params[:username] == "" || params[:password] == ""
        @error_message = "Sorry, all fields must be filled out. Try again."
        erb :'/users/error_message'
    else
      @user = User.new(:username => downcase_name, :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      erb :'roulettes/show_all_notes'
    end
  end


end 