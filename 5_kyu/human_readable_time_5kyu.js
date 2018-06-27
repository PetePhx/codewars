/*
Write a function, which takes a non-negative integer (seconds) as input and returns the time in a human-readable format (HH:MM:SS)

    HH = hours, padded to 2 digits, range: 00 - 99
    MM = minutes, padded to 2 digits, range: 00 - 59
    SS = seconds, padded to 2 digits, range: 00 - 59

The maximum time never exceeds 359999 (99:59:59)

You can find some examples in the test fixtures.
*/

function humanReadable(seconds) {
  var sec = seconds % 60;
  var min = (seconds - sec) / 60 % 60;
  var hr = (seconds - sec - min * 60) / 3600 % 100;

  return [hr, min, sec].map(String)
                       .map(str => str.length < 2 ? '0' + str : str)
                       .join(':');
}
