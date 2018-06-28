/*
Snail Sort

Given an n x n array, return the array elements arranged from outermost elements to the middle element, traveling clockwise.

array = [[1,2,3],
         [4,5,6],
         [7,8,9]]
snail(array) #=> [1,2,3,6,9,8,7,4,5]

For better understanding, please follow the numbers of the next array consecutively:

array = [[1,2,3],
         [8,9,4],
         [7,6,5]]
snail(array) #=> [1,2,3,4,5,6,7,8,9]

note: The idea is not sort the elements from the lowest value to the highest; the idea is to traverse the 2-d array in a clockwise snailshell pattern.

note 2: The 0x0 (empty matrix) is represented as [[]]
*/

snail = function(array) {
  if (array.length === 0) {
    return [];
  } else if (array.length === 1 ) {
    return array[0];
  } else if (array[0].length === 1) {
    return array.map(elm => elm[0]);
  }
  var out = [];
  var i;

  out.push(...array[0]);                                                  // top
  for (i = 1; i < array.length; i++) { out.push(array[i].slice(-1)[0]); } // right
  out.push(...array[array.length - 1].slice(0, -1).reverse());                 // bottom
  for (i = array.length - 2; i > 0; i--) { out.push(array[i][0]); }       // left

  return out.concat(...snail(array.slice(1, -1).map(ary => ary.slice(1, -1))));
}


array = [[1,2,3], [8,9,4], [7,6,5]];
snail(array); // #=> [1,2,3,4,5,6,7,8,9]

snail([[1], [2], [3], [4]]);  // [1, 2, 3, 4]

snail([[1, 2, 3, 4], [8, 7, 6, 5]]); // [1, 2, 3, 4, 5, 6, 7, 8]
