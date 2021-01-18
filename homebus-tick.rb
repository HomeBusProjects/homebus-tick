#!/usr/bin/env ruby

require 'mqtt'
require 'json'
require 'homebus'
require 'homebus_app'
require 'homebus_app_options'
require './app'
require './options'

tick_app_options = TickHomeBusAppOptions.new

tick = TickHomeBusApp.new tick_app_options.options
tick.run!
