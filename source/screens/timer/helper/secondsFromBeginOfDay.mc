import Toybox.Lang;
import Toybox.System;

// Returns the current time as seconds from the beginning of the day
function secondsFromBeginOfDay() as Number {
  var time = System.getClockTime();
  return time.hour * 3600 + time.min * 60 + time.sec;
}
