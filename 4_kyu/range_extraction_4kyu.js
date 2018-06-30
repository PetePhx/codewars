/*
A format for expressing an ordered list of integers is to use a comma separated list of either

    individual integers
    or a range of integers denoted by the starting integer separated from the end integer in the range by a dash, '-'. The range includes all integers in the interval including both endpoints. It is not considered a range unless it spans at least 3 numbers. For example ("12, 13, 15-17")

Complete the solution so that it takes a list of integers in increasing order and returns a correctly formatted string in the range format.

*/

function solution(list) {
  if (list.length === 0) return '';

  var splitArr = list.slice(1).reduce(function (acc, elm, idx) { // group to subarrays
    if (elm - list[idx] === 1) {
      acc[acc.length - 1].push(elm);
    } else {
      acc.push([elm]);
    }
    return acc;
  }, [[list[0]]]);

  var strArr = splitArr.map(function (elm) { // convert subarrays to strings
    if (elm.length <= 2) {
      return elm.join(',');
    } else {
      return elm[0] + '-' + elm[elm.length - 1];
    }
  });

  return strArr.join(','); // join the strings
}


console.log(solution([-6, -3, -2, -1, 0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 14, 15, 17, 18, 19, 20]));
// returns "-6,-3-1,3-5,7-11,14,15,17-20"
