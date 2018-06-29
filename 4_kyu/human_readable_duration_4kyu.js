/*
Your task in order to complete this Kata is to write a function which formats a duration, given as a number of seconds, in a human-friendly way.

The function must accept a non-negative integer. If it is zero, it just returns "now". Otherwise, the duration is expressed as a combination of years, days, hours, minutes and seconds.

It is much easier to understand with an example:

formatDuration(62)    // returns "1 minute and 2 seconds"
formatDuration(3662)  // returns "1 hour, 1 minute and 2 seconds"

For the purpose of this Kata, a year is 365 days and a day is 24 hours.

Note that spaces are important.
Detailed rules

The resulting expression is made of components like 4 seconds, 1 year, etc. In general, a positive integer and one of the valid units of time, separated by a space. The unit of time is used in plural if the integer is greater than 1.

The components are separated by a comma and a space (", "). Except the last component, which is separated by " and ", just like it would be written in English.

A more significant units of time will occur before than a least significant one. Therefore, 1 second and 1 year is not correct, but 1 year and 1 second is.

Different components have different unit of times. So there is not repeated units like in 5 seconds and 1 second.

A component will not appear at all if its value happens to be zero. Hence, 1 minute and 0 seconds is not valid, but it should be just 1 minute.

A unit of time must be used "as much as possible". It means that the function should not return 61 seconds, but 1 minute and 1 second instead. Formally, the duration specified by of a component must not be greater than any valid more significant unit of time.
*/

function formatDuration (seconds) {
  var yr = Math.floor(seconds / (365 * 24 * 3600));
  var dy = Math.floor((seconds % (365 * 24 * 3600)) / (24 * 3600));
  var hr = Math.floor(seconds % (24 * 3600) / 3600);
  var mn = Math.floor(seconds % 3600 / 60);
  var sc = seconds % 60;

  var yrStr = yr > 0 ? String(yr) + ' year' + (yr > 1 ? 's' : '') : '';
  var dyStr = dy > 0 ? String(dy) + ' day' + (dy > 1 ? 's' : '') : '';
  var hrStr = hr > 0 ? String(hr) + ' hour' + (hr > 1 ? 's' : '') : '';
  var mnStr = mn > 0 ? String(mn) + ' minute' + (mn > 1 ? 's' : '') : '';
  var scStr = sc > 0 ? String(sc) + ' second' + (sc > 1 ? 's' : '') : '';

  var strArr = [yrStr, dyStr, hrStr, mnStr, scStr].filter(x => x);

  if (strArr.length === 0) {
    return 'now';
  } else if (strArr.length === 1) {
    return strArr[0];
  } else {
    return strArr.slice(0, -1).join(', ') + ' and ' + strArr.slice(-1);
  }
}

// console.log(strArr);
console.log(formatDuration(60));    // returns "1 minute"
console.log(formatDuration(62));    // returns "1 minute and 2 seconds"
console.log(formatDuration(3662));  // returns "1 hour, 1 minute and 2 seconds"
