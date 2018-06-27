/*

You are given an array (which will have a length of at least 3, but could be very large) containing integers. The array is either entirely comprised of odd integers or entirely comprised of even integers except for a single integer N. Write a method that takes the array as an argument and returns this "outlier" N.
Examples

[2, 4, 0, 100, 4, 11, 2602, 36]
Should return: 11 (the only odd number)

[160, 3, 1719, 19, 11, 13, -21]
Should return: 160 (the only even number)

*/

/*
input: array of integers
output: the parity oulier integer

algorithm:
  - remArr: map the array to its remainder by 2
  - check whether remArr indexOf 0 === remArr lastIndexOf 0
    - if yes, return arr[remArr.indexOf(0)]
    - else, return arr[remArr.indexOf(1)]
*/

function findOutlier(arr) {
  var remArr = arr.map(elm => Math.abs(elm % 2));
  return arr[remArr.indexOf(remArr.indexOf(0) === remArr.lastIndexOf(0) ? 0 : 1)];
}
