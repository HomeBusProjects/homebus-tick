require 'homebus/options'

require 'homebus-tick/version'

class HomebusTick::Options < Homebus::Options
  def app_options(op)
  end

  def banner
    'HomeBus Ticker'
  end

  def version
    HomebusTick::VERSION
  end

  def name
    'homebus-tick'
  end
end
