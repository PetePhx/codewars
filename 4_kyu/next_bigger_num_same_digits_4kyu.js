/*
Next bigger number with the same digits

You have to create a function that takes a positive integer number and returns the next bigger number formed by the same digits:
*/

function nextBigger(n) {
  var digits = n.toString().split('').map(Number).reverse();
  var index = Array(digits.length).fill()
                                  .map((_, idx) => idx)
                                  .find(idx => digits[idx] > digits[idx + 1]);
  if (index === undefined) return -1;

  var curDigit = digits[index + 1];
  var tailDigits = digits.slice(0, index + 1).sort();
  var dgtIdx = Array(digits.length).fill()
                                   .map((_, idx) => idx)
                                   .find(idx => tailDigits[idx] > curDigit);
  var dgt = tailDigits[dgtIdx];
  tailDigits.splice(dgtIdx, 1);
  tailDigits = tailDigits.concat(curDigit).sort((a, b) => b - a);

  return Number(tailDigits.concat(dgt)
                          .concat(digits.slice(index + 2))
                          .reverse()
                          .join(''));
}

console.log(nextBigger(12)); // ==21
console.log(nextBigger(513)); // ==531
console.log(nextBigger(2017)); // ==2071
console.log(nextBigger(144)); // ==414

// If no bigger number can be composed using those digits, return -1:

// console.log(nextBigger(9)); // ==-1
// console.log(nextBigger(111)); // ==-1
// console.log(nextBigger(531)); // ==-1
