/*
Alright, detective, one of our colleagues successfully observed our target person, Robby the robber. We followed him to a secret warehouse, where we assume to find all the stolen stuff. The door to this warehouse is secured by an electronic combination lock. Unfortunately our spy isn't sure about the PIN he saw, when Robby entered it.

The keypad has the following layout:

┌───┬───┬───┐
│ 1 │ 2 │ 3 │
├───┼───┼───┤
│ 4 │ 5 │ 6 │
├───┼───┼───┤
│ 7 │ 8 │ 9 │
└───┼───┼───┘
    │ 0 │
    └───┘

He noted the PIN 1357, but he also said, it is possible that each of the digits he saw could actually be another adjacent digit (horizontally or vertically, but not diagonally). E.g. instead of the 1 it could also be the 2 or 4. And instead of the 5 it could also be the 2, 4, 6 or 8.

He also mentioned, he knows this kind of locks. You can enter an unlimited amount of wrong PINs, they never finally lock the system or sound the alarm. That's why we can try out all possible (*) variations.

* possible in sense of: the observed PIN itself and all variations considering the adjacent digits

Can you help us to find all those variations? It would be nice to have a function, that returns an array of all variations for an observed PIN with a length of 1 to 8 digits. We could name the function getPINs (get_pins in python). But please note that all PINs, the observed one and also the results, must be strings, because of potentially leading '0's. We already prepared some test cases for you.
*/

// function extMult(arr1, arr2) {
//   var out = [];
//   for (var i = 0; i < arr1.length; i++) {
//     for (var j = 0; j < arr2.length; j++) {
//       out.push(arr1[i] + arr2[j]);
//     }
//   }
//   return out;
// }

function getPINs(observed) {
  if (observed.length === 0) return [''];
  return extMult(adjacent(observed[0]), getPINs(observed.slice(1)));
}

function extMult(arr1, arr2) {
  return arr1.reduce((acc, x) => acc.concat(...arr2.map(y => x + y)), []);
}

function adjacent(chr) {
  switch (chr) {
    case '0': return ['0', '8'];
    case '1': return ['1', '2', '4'];
    case '2': return ['2', '1', '3', '5'];
    case '3': return ['3', '2', '6'];
    case '4': return ['4', '1', '5', '7'];
    case '5': return ['5', '2', '4', '6', '8'];
    case '6': return ['6', '3', '5', '9'];
    case '7': return ['7', '4', '8'];
    case '8': return ['0', '8', '5', '7', '9'];
    case '9': return ['9', '6', '8'];
  }
}

console.log(extMult(['a', 'b'], ['c', 'd'])); // [ 'ac', 'ad', 'bc', 'bd' ]

console.log(getPINs('1')); // [ '1', '2', '4' ]

console.log(getPINs('11')); // ["11", "22", "44", "12", "21", "14", "41", "24", "42"],
