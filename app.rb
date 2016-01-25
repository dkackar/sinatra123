require 'sinatra'
require_relative 'lib/tower_of_hanoi'
require 'json'

enable :sessions

 get '/' do 

  toh = TowerOfHanoi.new
  session[:game_state] = toh.towers.to_json
  towers = toh.towers

  erb :game, :locals => {:towers => towers}
   
 end


 post '/' do 

  towers = JSON.parse(session[:game_state])
  toh = TowerOfHanoi.new(towers)
  
  session[:towers] = toh.towers.to_json

  erb :game, :locals => {:towers => towers}
   
 end

