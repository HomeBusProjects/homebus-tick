# HomeBus Tick

This is a simple Ruby program which publishes a "tick" to HomeBus once per second. The tick includes the number of seconds since the epoch as well as the current year, month, month day, weekday, hour, minute, second and timezone information.

While the tick is published once a second, timing critical applications should not rely on its frequency as there can be indeterminate latency between the publish time and the time it's received.
