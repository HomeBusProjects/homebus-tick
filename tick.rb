#!/usr/bin/env ruby

require 'mqtt'
require 'dotenv/load'
require 'json'
require 'net/http'
require 'pp'

Dotenv.load '.env.provision'

require 'homebus'

opts = []

mqtt = { host: ENV['MQTT_HOSTNAME'],
         port: ENV['MQTT_PORT'],
         username: ENV['MQTT_USERNAME'],
         password: ENV['MQTT_PASSWORD'],
       }

uuid = ENV['UUID']

pp mqtt if opts[:debug]


if mqtt[:host].nil?
  puts 'host is nil'

  mqtt = HomeBus.provision serial_number: '00-00-00-00',
                           manufacturer: 'Homebus',
                           model: 'tick',
                           friendly_name: 'System Ticker',
                           pin: '',
                           devices: [ {
                                        friendly_name: 'System Ticker',
                                        friendly_location: 'The Core',
                                        update_frequency: 1000,
                                        accuracy: 10,
                                        precision: 100,
                                        wo_topics: [ 'tick' ],
                                        ro_topics: [],
                                        rw_topics: []
                                      } ]
                                                        
  
  unless mqtt
    abort 'MQTT provisioning failed'
  end

  pp mqtt if opts[:debug]

  uuid = mqtt[:uuid]
  mqtt.delete :uuid
end

client = MQTT::Client.connect mqtt

loop do 
  tick_msg = {
    uuid: uuid,
    timestamp: Time.now.to_i,
    year: Time.now.year,
    month: Time.now.month,
    month_day: Time.now.mday,
    weekday: Time.now.wday,
    hour: Time.now.hour,
    minute: Time.now.min,
    second: Time.now.sec,
    timezone_code: Time.now.zone,
    timezone_offset: Time.now.utc_offset
  }

  pp tick_msg if opts[:verbose]
  
  client.publish('tick', tick_msg.to_json, true)
  puts 'ticked' if opts[:verbose]

  sleep 1            
end
