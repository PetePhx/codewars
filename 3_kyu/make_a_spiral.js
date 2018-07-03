/*
Your task, is to create a NxN spiral with a given size.

For example, spiral with size 5 should look like this:

00000
....0
000.0
0...0
00000

and with the size 10:

0000000000
.........0
00000000.0
0......0.0
0.0000.0.0
0.0..0.0.0
0.0....0.0
0.000000.0
0........0
0000000000

Return value should contain array of arrays, of 0 and 1, for example for given size 5 result should be:

[[1,1,1,1,1],[0,0,0,0,1],[1,1,1,0,1],[1,0,0,0,1],[1,1,1,1,1]]

Because of the edge-cases for tiny spirals, the size will be at least 5.

General rule-of-a-thumb is, that the snake made with '1' cannot touch to itself.

*/

/*
- input: size of the lattice, n (>= 5)
- output: n-by-n spiral

- algorithm:
  - start with spiralNoTail
  - set the base cases for 3x3 and 4x4 spirals
  - for general n:
    - maze(2:n, 0:n-2) is spiralNoTail(n - 2), 180 degree rotated
    - right wall: set to 1
    - bottom wall: set to 1

  - spiral: get spiralNoTail, set the top wall to 1
*/

function spiral(n) {
  return spiralNoTail(n).map((row, idx) => idx === 0 ? Array(n).fill(1) : row);
}

function spiralNoTail(n) {
  if (n === 3) return [[0, 0, 1], [0, 0, 1], [1, 1, 1]];
  if (n === 4) return [[0, 0, 0, 1], [0, 0, 0, 1], [1, 0, 0, 1], [1, 1, 1, 1]];

  var submatrix = rotate180(spiralNoTail(n - 2));
  var matrix = submatrix.map(arr => arr.concat([0, 0]));  // add right columns
  matrix.unshift(Array(n).fill(0), Array(n).fill(0));     // add top rows
  matrix.forEach(row => row[n - 1] = 1);                  // right wall
  matrix[n - 1].fill(1);                                  // bottom wall

  return matrix;
}

function rotate180(matrix) {
  return matrix.map(arr => arr.slice().reverse()).reverse();
}

console.log(spiral(10));

// [ [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ],
//   [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
//   [ 1, 1, 1, 1, 1, 1, 1, 1, 0, 1 ],
//   [ 1, 0, 0, 0, 0, 0, 0, 1, 0, 1 ],
//   [ 1, 0, 1, 1, 1, 1, 0, 1, 0, 1 ],
//   [ 1, 0, 1, 0, 0, 1, 0, 1, 0, 1 ],
//   [ 1, 0, 1, 0, 0, 0, 0, 1, 0, 1 ],
//   [ 1, 0, 1, 1, 1, 1, 1, 1, 0, 1 ],
//   [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
//   [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ]
