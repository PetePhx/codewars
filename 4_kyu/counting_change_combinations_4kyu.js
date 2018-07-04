/*

Counting Change Combinations

Write a function that counts how many different ways you can make change for an amount of money, given an array of coin denominations. For example, there are 3 ways to give change for 4 if you have coins with denomination 1 and 2:

1+1+1+1, 1+1+2, 2+2.

The order of coins does not matter:

1+1+2 == 2+1+1

Also, assume that you have an infinite amount of coins.

Your function should take an amount to change and an array of unique denominations for the coins:

*/

/*
- ALgorithm

  - recursive solution
    - base case of one denomination:
      - if total === Math.floor(total / coins[0]) * coins[0], return 1
      - else return 0
    - general case:
      - choose the first element, coins[0], (c)
      - build an array of values: [0, c, 2 * c, ..., m * c] such that m * c < total
      - for value in the array, calculate: countChange(total - val, coins.slice(1))
      - sum the returned values for each val return

*/

function countChange(money, coins) {
  if (money < 0 || coins.length === 0) return 0; // invalid input
  if (coins.length === 1) return (money === Math.floor(money / coins[0]) * coins[0] ? 1 : 0);   // recursion base

  var valsArr = Array(Math.floor(money / coins[0]) + 1).fill().map((_, idx) => idx * coins[0]); // possible values
  return valsArr.reduce((acc, val) => acc + countChange(money - val, coins.slice(1)), 0);       // recursion
}

console.log(countChange(5, [1]));
console.log(countChange(3, [4]));

console.log(countChange(4, [1,2])); // => 3
console.log(countChange(10, [5,2,3])); // => 4
console.log(countChange(11, [5,7])); //  => 0
