
require 'sinatra/base'
require 'sinatra/contrib'
require 'chartkick'
require "sinatra/activerecord"

class TemperatureMonitor < Sinatra::Base
  register Sinatra::Contrib
  register Sinatra::ActiveRecordExtension

  set :database, {adapter: "sqlite3", database: "temperatures.sqlite3"}

  Thread.new do # trivial example work thread
    fridge = Ds18b20::Parser.new("/sys/bus/w1/devices/28-800000048d57/w1_slave")
    while true do
      
      sleep 10
    end
  end

  get '/' do
    @title = "Temperatures"
    @fridge = {'2015-07-20 00:00:00 UTC' => 2, '2015-07-21 00:00:00 UTC' => 4, '2015-07-22 00:00:00 UTC' => 1, '2015-07-23 00:00:00 UTC' => 7}
    @freezer = {}
    erb :chart
  end

end