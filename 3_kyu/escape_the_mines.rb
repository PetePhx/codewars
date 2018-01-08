=begin

A poor miner is trapped in a mine and you have to help him to get out !

Only, the mine is all dark so you have to tell him where to go.

In this kata, you will have to implement a method solve(map, miner, exit) that
has to return the path the miner must take to reach the exit as an array of
moves, such as : ['up', 'down', 'right', 'left']. There are 4 possible moves,
up, down, left and right, no diagonal.

map is a 2-dimensional array of boolean values, representing squares. false for
walls, true for open squares (where the miner can walk). It will never be larger
than 5 x 5. It is laid out as an array of columns. All columns will always be
the same size, though not necessarily the same size as rows (in other words,
maps can be rectangular). The map will never contain any loop, so there will
always be only one possible path. The map may contain dead-ends though.

miner is the position of the miner at the start, as an object made of two zero-
based integer properties, x and y. For example {x:0, y:0} would be the top-left
corner.

exit is the position of the exit, in the same format as miner.

Note that the miner can't go outside the map, as it is a tunnel.

Let's take a pretty basic example :

map = [[true, false],
    [true, true]];

solve(map, {'x'=>0,'y'=>0}, {'x'=>1,'y'=>1})
# Should return ['right', 'down']

=end

=begin

- input : map (array of columns), hash (start), hash (exit)
- ouput : array (moves: right or left or up or down)
- algorithm :
  - use a helper method #explore to explore the map area
  - #explore receives the path so far travelled as a parmeter (array of positions)
  - #explore performs a recursive search of the map.
    - in each step check:
      - whether at the target: return the path
      - the boundaries
      - hit the wall
    - next explore the 4 directions
      - excluding directions that cross the previously travelled path
  - in the #solve method, translate the path travelled (array of [x,y] positions)
    to up/down/right/left directions based on change in nidices
    reminder: matric directions:
                                      ---> y (down)
                                      |
                                      |
                                      x (right)

=end

def solve(minemap, miner, stop)
  target = stop.values
  path = explore([miner.values], minemap, miner['x'], miner['y'], target)
  moves = (1...path.length).each_with_object([]) do |idx , obj|
            obj << case path[idx][0] - path[idx - 1][0]
                   when 1 then 'right'
                   when -1 then 'left'
                   when 0 then case path[idx][1] - path[idx - 1][1]
                               when 1 then 'down'
                               when -1 then 'up'
                               end
                   end
          end
end

def explore(path, minemap, x, y, target)
  return path if [x, y] == target
  return false unless (0...minemap.size).cover?(x) &&
                      (0...minemap[0].size).cover?(y) &&
                      minemap[x][y]
  [[x, y - 1], [x, y + 1], [x + 1, y], [x - 1, y]].map do |pos|
    !path.include?(pos) && explore(path + [pos], minemap, *pos, target)
  end.reduce{|a, b| a || b}
end
# (!path.include?([x, y-1]) && explore(path + [[x, y-1]], minemap, x, y-1, target)) ||
# (!path.include?([x, y+1]) && explore(path + [[x, y+1]], minemap, x, y+1, target)) ||
# (!path.include?([x+1, y]) && explore(path + [[x+1, y]], minemap, x+1, y, target)) ||
# (!path.include?([x-1, y]) && explore(path + [[x-1, y]], minemap, x-1, y, target))

minemap = [[true, true, true],
  [false, false, true],
  [true, true, true]]

miner = {'x'=>0,'y'=>0}
stop = {'x'=>2,'y'=>0}

# minemap = [[true]]
#
# miner = {'x'=>0,'y'=>0}
# stop = {'x'=>0,'y'=>0}

p solve(minemap, miner, stop)
