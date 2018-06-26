/*
Build Tower

Build Tower by the following given argument:
number of floors (integer and always greater than 0).

Tower block is represented as *

    Python: return a list;
    JavaScript: returns an Array;
    C#: returns a string[];
    PHP: returns an array;
    C++: returns a vector<string>;
    Haskell: returns a [String];
    Ruby: returns an Array;

Have fun!

for example, a tower of 3 floors looks like below

[
  '  *  ',
  ' *** ',
  '*****'
]

and a tower of 6 floors looks like below

[
  '     *     ',
  '    ***    ',
  '   *****   ',
  '  *******  ',
  ' ********* ',
  '***********'
]
*/

/*
input: positive integer, (num)
output: array of strins of stars (arr)

algorithm:
  - find the length of floors: 2 * num - 1
  - composition of each floor (idx): (num - idx - 1) ' ' + (2 * idx + 1) '*' + (num - idx - 1) ' '

  - create an array of length num
  - map each index (idx) to the string pattern
  - return the array
*/

function towerBuilder(num) {
  return [...Array(num)].map(function(_, idx) {
    return ' '.repeat(num - idx - 1) + '*'.repeat(2 * idx + 1) + ' '.repeat(num - idx - 1)
  });
}
