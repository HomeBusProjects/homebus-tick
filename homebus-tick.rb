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
  DDC = 'org.homebus.tick'

  def setup!
  end

  def work!
    t = Time.now

    tick_msg = {
      source: @uuid,
      timestamp: t.to_i,
      contents: {
        ddc: DDC,
        payload: {
          epoch: t.to_i,
          year: t.year,
          month: t.month,
          month_day: t.mday,
          weekday: t.wday,
          hour: t.hour,
          minute: t.min,
          second: t.sec,
          timezone_code: t.zone,
          timezone_offset: t.utc_offset
        }
      }
    }

    if @options[:verbose]
      pp tick_msg
    end
  
    publish! DDC, tick_msg

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
        wo_topics: [ DDC ],
        ro_topics: [],
        rw_topics: []
      } ]
  end
end

tick_app_options = TickHomeBusAppOptions.new

tick = TickHomeBusApp.new tick_app_options.options
tick.run!
