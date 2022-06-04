
require 'sinatra/base'
require 'sinatra/contrib'
require "sinatra/json"
require 'chartkick'
require "sinatra/activerecord"
require 'active_support/all'

Time.zone = "America/New_York"
ActiveRecord::Base.default_timezone = :utc

class TemperatureMonitor < Sinatra::Base
  register Sinatra::Contrib
  register Sinatra::ActiveRecordExtension

  set :database, {adapter: "sqlite3", database: "temperatures.sqlite3"}

  get '/' do
    erb :chart
  end

  get '/data.json' do
    hours = params['hours'].to_i
    res = Temperature.distinct.pluck(:location).map do |sensors|
      { name: sensors, data: Temperature.where(location: sensors).where('created_at > ?', hours.hours.ago).map { |temp| [temp.created_at.in_time_zone('America/New_York'), temp.temperature] }.to_h }
    end << {name: "Max Acceptable", data: Temperature.all.where('created_at > ?', hours.hours.ago).map { |temp| [temp.created_at.in_time_zone('America/New_York'), 40.0] }}
    json res
  end

end

class Temperature < ActiveRecord::Base; end
