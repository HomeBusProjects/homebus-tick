# HomeBus Tick

This is a simple Ruby program which publishes a "tick" to HomeBus once per second. The tick includes the number of seconds since the epoch as well as the current year, month, month day, weekday, hour, minute, second and timezone information.

While the tick is published once a second, timing critical applications should not rely on its frequency as there can be indeterminate latency between the publish time and the time it's received.

Data is published as 'org.homebus.tick':

```
    'org.homebus.tick': {
                            year: 2020,
                            month: 1,
                            month_day: 1,
                            weekday: 1,
                            hour: 0,
                            minute: Time.now.min,
                            second: Time.now.sec,
                            timezone_code: Time.now.zone,
                            timezone_offset: Time.now.utc_offset
                          }
 ```

- year: four digit year
- month: one digit month number, 1 - 12
- month_day: one to two digit day of the month number, 1-31
- weekday: one digit day of the week number, 1-7 (Sunday - Saturday)
- hour: two digit hour number, 0 - 23
- minute:  two digit minute number, 0 - 59
- second:  two digit second number, 0 - 59
- timezone_code: text timezone code, for instance ""
- numeric timezone offset from UTC
