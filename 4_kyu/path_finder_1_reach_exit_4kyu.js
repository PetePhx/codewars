/*

Task

You are at position [0, 0] in maze NxN and you can only move in one of the four cardinal directions (i.e. North, East, South, West). Return true if you can reach position [N-1, N-1] or false otherwise.

Empty positions are marked .. Walls are marked W. Start and exit positions are empty in all test cases.

*/

/*

- input: N by N maze (array) of empty squares ('.') and walls ('W')
- output: boolean. whether or not maze[N-1][N-1] can be connected to maze[0][0]

- Algorithm

  - set traveled squares (travSq) to empty []
  - set new squares (newSq) to [ '0,0' ]

  - Run a While loop: while new squares are not empty
    - for each new square:
      - move it from new squares to traveled squares
      - Look at the 4 (up down right left) neighbors:
        - if any is [N-1, N-1], return true.
        - The ones NOT traveled, and NOT in new squares: add to new squares

  - return false  (Check whether [N-1, N-1] is traveled)
*/

function pathFinder(maze) {
  var map = maze.map(arr => arr.slice());
  var len = map.length;
  var neighArr = [[0, 0]];
  map[0][0] = 'T'; // travelled square

  do { // as long as there are new un-travelled squares
    neighArr = availNeigh(map);
    neighArr.forEach(pair => map[pair[0]][pair[1]] = 'T');
  } while (neighArr.length > 0);
  return map[len - 1][len - 1] === 'T' ? true : false;
}

function availNeigh(map) { // available neighbor squares
  var out = [];
  var len = map.length;

  for (var i = 0; i < len; i++) {
    for (var j = 0; j < len; j++) {
      if (map[i][j] === 'T') {
        if (map[i - 1] && map[i - 1][j] === '.') out.push([i - 1, j]);
        if (map[i + 1] && map[i + 1][j] === '.') out.push([i + 1, j]);
        if (map[i][j - 1] && map[i][j - 1] === '.') out.push([i, j - 1]);
        if (map[i][j + 1] && map[i][j + 1] === '.') out.push([i, j + 1]);
      }
    }
  }
  return out;
}

// console.log(availNeigh([['T', '.'], ['.', '.']]));
// console.log(availNeigh([['T', 'T'], ['.', '.']]));
// console.log(availNeigh([['T', 'T'], ['T', '.']]));
// console.log(availNeigh([['T', 'T'], ['T', 'T']]));



maze = [ ['.', '.'], ['.', '.'] ];
console.log(pathFinder(maze));
