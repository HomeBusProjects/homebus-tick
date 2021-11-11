#!/usr/bin/env ruby

require './app'
require './options'

tick_app_options = TickHomebusAppOptions.new

tick = TickHomebusApp.new tick_app_options.options
tick.run!
