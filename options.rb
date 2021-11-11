class TickHomebusAppOptions < Homebus::Options
  def app_options(op)
  end

  def banner
    'HomeBus Ticker'
  end

  def version
    '0.9.0'
  end

  def name
    'homebus-tick'
  end
end
