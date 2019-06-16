require "./app"
require 'ds18b20'

devices = []
Dir.glob('/sys/bus/w1/devices/28-*').each do |dev|
    devices << Ds18b20::Parser.new("#{dev}/w1_slave")
end
while true do
    devices.each_with_index do |device, index|
        Temperature.create(temperature: device.fahrenheit, location: "Sensor ##{index}")
    end
    sleep 60
end