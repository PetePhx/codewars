=begin
Your granny, who lives in town X0, has friends. These friends are given in an array, for example: array of friends is

[ "A1", "A2", "A3", "A4", "A5" ].

The order of friends is this array must not be changed since this order gives the order in which they will be visited.

These friends inhabit towns and you have an array with friends and towns, for example:

[ ["A1", "X1"], ["A2", "X2"], ["A3", "X3"], ["A4", "X4"] ]
or
(C)
{"A1", "X1", "A2", "X2", "A3", "X3", "A4", "X4"}

which means A1 is in town X1, A2 in town X2... It can happen that we don't know the town of one of the friends.

Your granny wants to visit her friends and to know how many miles she will have to travel.

You will make the circuit that permits her to visit her friends. For example here the circuit will contain:

X0, X1, X2, X3, X4, X0

and you must compute the total distance

X0X1 + X1X2 + .. + X4X0.

For the distance, fortunately, you have a map (and a hashmap) that gives each distance X0X1, X0X2 and so on. For example:

[ ["X1", 100.0], ["X2", 200.0], ["X3", 250.0], ["X4", 300.0] ]
or (Coffeescript, Javascript)
['X1',100.0, 'X2',200.0, 'X3',250.0, 'X4',300.0 ]
or
(C)
{"X1", "100.0", "X2", "200.0", "X3", "250.0", "X4", "300.0"}

which means that X1 is at 100.0 miles from X0, X2 at 200.0 miles from X0, etc...

More fortunately (it's not real life, it's a story...), the towns X0, X1, ..Xn are placed in the following manner:

X0X1X2 is a right triangle with the right angle in X1, X0X2X3 is a right triangle with the right angle in X2, etc...

If a town Xi is not visited you will suppose that the triangle

X0Xi-1Xi+1 is still a right triangle.

(Ref: https://en.wikipedia.org/wiki/Pythagoras#Pythagorean_theorem)
Task

Can you help your granny and give her the distance to travel?
=end

=begin
- input: array of : friends, cities, distances
      each distance is from city n to city 0
- output: integer: total distance to be travelled from city 0 to 1, 2, ... to 0

- algorithm:
  iterate through cities, add distances in each step:
    - for city 1, distance is d1
    - for city k between 2 to n:
      - distance is sqrt(d_k**2 - d_(k-1)**) : pythagorean theorem
    - for city 0, distance is d_n
  return distance
=end

def tour(friends, f_towns, dist_hash)
  sum_dist = 0
  return sum_dist if friends.size == 0
  towns = f_towns.select { |arr| friends.include?(arr[0]) && dist_hash.keys.include?(arr[1]) }
  towns = towns.sort_by { |arr| friends.index(arr[0]) }.map { |arr| arr[1] }
  dist_arr = dist_hash.select{ |k,v| towns.include?(k) }.to_a
  dist_arr = dist_arr.sort_by{ |arr| towns.index(arr[0]) }.map { |arr| arr[1] }
  sum_dist += dist_arr[0]
  1.upto(dist_arr.size - 1) do |idx|
    sum_dist += Math::sqrt(dist_arr[idx]**2 - dist_arr[idx - 1]**2)
  end
  sum_dist = (sum_dist + dist_arr.last).to_i
end

friends = ["A1", "A2", "A3", "A4", "A5"]
f_towns = [["A2", "X2"], ["A1", "X1"], ["A3", "X3"], ["A4", "X4"]]
dist_hash = Hash["X2", 200.0, "X1", 100.0, "X3", 250.0, "X4", 300.0]

# p dist_hash
p tour(friends, f_towns, dist_hash)

friends = ["A1"]
f_towns = [["A1", "X1"]]
dist_hash = Hash["X1", 100.0]

p tour(friends, f_towns, dist_hash)

friends = []
f_towns = []
dist_hash = Hash[]

p tour(friends, f_towns, dist_hash)


friends = ["A1", "A2"]
f_towns = [["A2", "X2"], ["A1", "X1"]]
dist_hash = Hash["X2", 200.0, "X1", 100.0]

# p dist_hash
p tour(friends, f_towns, dist_hash)

friends = ["A1", "A2", "A3", "A4", "A5"]
f_towns = [["A2", "X2"], ["A1", "X1"], ["A3", "X3"], ["A4", "X4"], ["A5", nil]]
dist_hash = Hash["X2", 200.0, "X1", 100.0, "X3", 250.0, "X4", 300.0]
