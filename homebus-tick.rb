#!/usr/bin/env ruby

require 'mqtt'
require 'json'

require 'homebus'
require 'homebus_app'
require 'homebus_app_options'

require 'pp'

class TickHomeBusAppOptions < HomeBusAppOptions
  def app_options(op)
  end

  def banner
    'HomeBus Ticker'
  end

  def version
    '0.0.1'
  end

  def name
    'homebus-tick'
  end
end

class TickHomeBusApp < HomeBusApp
  def setup!
  end

  def work!
    tick_msg = {
      id: @uuid,
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

    if @options[:verbose]
      pp tick_msg if @options[:verbose]
    end
  
    @mqtt.publish('/tick', tick_msg.to_json, true)

    sleep 1
  end

  def manufacturer
    'HomeBus'
  end

  def model
    'Basic'
  end

  def friendly_name
    'Ticker'
  end

  def friendly_location
    'HomeBus Core'
  end

  def serial_number
    ''
  end

  def pin
    ''
  end

  def devices
    [ {
        friendly_name: 'System Ticker',
        friendly_location: 'The Core',
        update_frequency: 1000,
        accuracy: 10,
        precision: 100,
        wo_topics: [ 'tick' ],
        ro_topics: [],
        rw_topics: []
      } ]
  end
end

tick_app_options = TickHomeBusAppOptions.new

tick = TickHomeBusApp.new tick_app_options.options
tick.run!
