/*
In this finite version of Conway's Game of Life (here is an excerpt of the rules) ...

The universe of the Game of Life is an infinite two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, alive or dead. Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:

    Any live cell with fewer than two live neighbours dies, as if caused by under-population.

    Any live cell with two or three live neighbours lives on to the next generation.

    Any live cell with more than three live neighbours dies, as if by overcrowding.

    Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

The initial pattern constitutes the seed of the system. The first generation is created by applying the above rules simultaneously to every cell in the seed—births and deaths occur simultaneously, and the discrete moment at which this happens is sometimes called a tick (in other words, each generation is a pure function of the preceding one)

...implement your own method which will take the initial state as an NxM array of 0's (dead cell) and 1's (living cell) and return an equally sized array representing the next generation. Cells outside the array must be considered dead. Cells that would born out of the array boundaries should be ignored (universe never grows beyond the initial NxM grid).
N.B.: for illustration purposes, 0 and 1 will be represented as ░ and ▓ blocks (PHP: basic black and white squares) respectively. You can take advantage of the 'htmlize' function to get a text representation of the universe:
eg:

console.log(htmlize(cells));
*/

/*
input: array of arrays (rows), 0s, 1s
output: array of rows, same size, 0s, 1s

algo:
  - calculate the neighbor count
  - update status
*/

function nextGen(cells){
  if (cells.length === 0) return cells;
  var neighbors = countNeighbors(cells);
  for (var i = 0; i < cells.length; i++) {
    for (var j = 0; j < cells[0].length; j++){
      if (cells[i][j] === 0) {                         // dead cell ...
        if (neighbors[i][j] === 3) cells[i][j] = 1; // becomes alive!
      } else {                                         // living cell...
        if (neighbors[i][j] < 2 || neighbors[i][j] > 3) cells[i][j] = 0;  // dies!
      }
    }
  }

  return cells;
}

function countNeighbors(cells) {
  // padding on 4 sides:
  var countArr = Array(cells.length + 2);
  for (var k = 0; k < countArr.length; k++) { countArr[k] = Array(cells[0].length + 2).fill(0); }

  for (var i = 0; i < cells.length; i++) {
    for (var j = 0; j < cells[0].length; j++){
      if (cells[i][j] === 1){
        countArr[i][j]++;          // upper left
        countArr[i][j + 1]++;      // up
        countArr[i][j + 2]++;      // upper righ
        countArr[i + 1][j]++;      // left
        countArr[i + 1][j + 2]++;  // right
        countArr[i + 2][j]++;      // lower left
        countArr[i + 2][j + 1]++;  // bottom
        countArr[i + 2][j + 2]++;  // lower right
      }
    }
  }
  // un-padding:
  return countArr.slice(1, -1).map(ary => ary.slice(1, -1));
}

//test

var cells = [[1, 1, 0], [1, 0, 0], [0, 0, 0]];

// center cell becomes alive:
console.log(...nextGen(cells)); // [ 1, 1, 0 ] [ 1, 1, 0 ] [ 0, 0, 0 ]
