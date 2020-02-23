class RoulettesController < ApplicationController


  post '/' do
    if logged_in?
      
      spins_array = params[:landed_number].gsub(" ", "").split(",")

      spins_array.each do |y|
        if (y.to_i <= 36) && (y.length < 3)
          z = Spin.new
          z.landed = y 
          z.save
        end
      end

      spins_array.each do |i|
        if i == "00"
          x = Roulette.find_by_id(38)
          x.landing_frequency += 1
          x.save
        elsif i == "0"
          x = Roulette.find_by_id(37)
          x.landing_frequency += 1
          x.save
        else
          x = Roulette.find_by_id(i.to_i)
          if x && (x.id <= 36)
            x.landing_frequency += 1
            x.save
          end
        end
      end
        erb :'roulettes/show_all_notes'
    else
      redirect to '/'
    end
  end


  delete '/delete' do
    if logged_in?
      Spin.delete_all
      Roulette.update_all("landing_frequency = 0")
      erb :'roulettes/show_all_notes'
    else
      redirect '/'
    end
  end



end 