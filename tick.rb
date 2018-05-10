#!/usr/bin/env ruby

require 'mqtt'
require 'dotenv/load'
require 'json'
require 'net/http'
require 'pp'

Dotenv.load '.env.provision'

require 'homebus'

mqtt = { host: ENV['MQTT_HOSTNAME'],
         port: ENV['MQTT_PORT'],
         username: ENV['MQTT_USERNAME'],
         password: ENV['MQTT_PASSWORD'],
       }

uuid = ENV['UUID']

pp mqtt

if mqtt[:host].nil?
  puts 'host is nil'

  mqtt = HomeBus.provision "00:11:22:33:44:55"
  unless mqtt
    abort 'MQTT provisioning failed'
  end

  pp mqtt

  uuid = mqtt[:uuid]
  mqtt.delete :uuid
end

client = MQTT::Client.connect mqtt

loop do 
  tick_msg = {
    uuid: uuid,
    seconds_since_epoch: Time.now.to_i
  }

  puts 'about to tick'
  pp tick_msg
  
  client.publish('/tick', tick_msg.to_json, true)
  puts 'ticked'

  sleep 1            
end
