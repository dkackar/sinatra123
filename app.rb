require 'sinatra'
require_relative 'lib/tower_of_hanoi'
require 'json'

enable :sessions

 get '/' do 

  toh = TowerOfHanoi.new
  session[:game_state] = toh.towers.to_json
  towers = toh.towers

  erb :game, :locals => {:towers => towers, :message => ""}
   
 end


 post '/' do 

  towers = JSON.parse(session[:game_state])
  toh = TowerOfHanoi.new(towers)
  
  to   = params[:To]
  from = params[:From]
  
  if toh.valid_move?(from.to_i,to.to_i)
     toh.move(from.to_i,to.to_i)
     towers = toh.towers
     session[:game_state] = towers.to_json
     if toh.win?
        message = "You win"
     else   
        message = ""
     end
  else
     message = "Invalid move"
  end  
  
  erb :game, :locals => {:towers => towers, :message => message}
 end

