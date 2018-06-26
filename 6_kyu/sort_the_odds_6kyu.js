/*
You have an array of numbers.
Your task is to sort ascending odd numbers but even numbers must be on their places.

Zero isn't an odd number and you don't need to move it. If you have an empty array, you need to return it.

Example

sortArray([5, 3, 2, 8, 1, 4]) == [1, 3, 2, 8, 5, 4]
*/

/*
- input: array of non-negative integers
- output: sorted odds array

-algorithm:
  - var oddsArr: filter to keep the odd elements
  - sort oddsArr
  - loop through the original array
    if element is odd, replace with a shifted element from oddsArr
  - return arr
*/


function sortArray(origArr) {
  var arr = origArr.slice(); // so as not to mutate the argument
  var oddsArr = arr.filter(x => x % 2 === 1).sort((x, y) => x - y);
  for (var i = 0; i < arr.length; i++) { if (arr[i] % 2 === 1) arr[i] = oddsArr.shift(); }
  return arr;
}
