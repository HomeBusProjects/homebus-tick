class TickHomeBusApp < HomeBusApp
  DDC_TICK = 'org.homebus.experimental.tick'
  DDC_CLOCK = 'org.homebus.experimental.clock'

  def setup!
  end

  def work!
    t = Time.now

    tick_msg = {
      epoch: t.to_i
    }

    clock_msg = {
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

    if @options[:verbose]
      pp tick_msg
    end
  
    # this will likely cause us to mmiss a tick once in a while
    # instead we should do something like sleep, wakeup, fork a child to do the work and sleep again
    publish! DDC_TICK, tick_msg
    publish! DDC_CLOCK, clock_msg

    sleep 1
  end

  def manufacturer
    'HomeBus'
  end

  def model
    'Core'
  end

  def serial_number
    ''
  end

  def pin
    ''
  end

  def publish_ddcs
    [ DDC_TICK, DDC_CLOCK ]
  end

  def consume_ddcs
  end
end
