/*
#Find the missing letter

Write a method that takes an array of consecutive (increasing) letters as input and that returns the missing letter in the array.

You will always get an valid array. And it will be always exactly one letter be missing. The length of the array will always be at least 2.
The array will always contain letters in only one case.

Example:

['a','b','c','d','f'] -> 'e'
['O','Q','R','S'] -> 'P'

(Use the English alphabet with 26 letters!)
*/

/*
-input: array of letters
-output: string, the missing letters

-algorithm:
  - map the characters in the array to ascii codes: charCodeAt()
  - loop through the array, looking for arr[i + 1] - arr[i] > 1
  - return the character: fromCharCode(arr2[i] + 1)
*/

function findMissingLetter(arr) {
  var arr2 = arr.map(elm => elm.charCodeAt());
  for (var i = 0; i < arr2.length; i++) {
    if (arr2[i + 1] - arr2[i] > 1) return String.fromCharCode(arr2[i] + 1);
  }
}
