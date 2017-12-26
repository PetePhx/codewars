=begin

We want to generate all the numbers of three digits that:

    the value of adding their corresponding ones(digits) is equal to 10.

    their digits are in increasing order (the numbers may have two or more equal
    contiguous digits)

The numbers that fulfill the two above constraints are: 118, 127, 136, 145, 226,
235, 244, 334

Make a function that receives two arguments:

    the sum of digits value

    the amount of desired digits for the numbers

The function should output an array with three values: [1,2,3]

1 - the total amount of all these possible numbers

2 - the minimum number

3 - the maximum numberwith

The example given above should be:

find_all(10, 3) == [8, 118, 334]

If we have only one possible number as a solution, it should output a result
like the one below:

find_all(27, 3) == [1, 999, 999]

If there are no possible numbers, the function should output the empty array.

find_all(84, 4) == []

The number of solutions climbs up when the number of digits increases.

find_all(35, 6) == [123, 116999, 566666]

Features of the random tests:

Numbers of tests: 111
Sum of digits value between 20 and 65
Amount of digits between 2 and 15

=end

=begin
  - input: two integers: sum of digits (sum), number of digits (num)

  -output: an array, containing:

        1 - the total amount of all these possible numbers

        2 - the minimum number

        3 - the maximum numberwith

  - algorithm:

    - The "sum" (n) is going to be divided among "num" (k) digits.
        digits monotonically increasing in order. can NOT be 0.
    - Problem of sum "balls", with sum + 1 boundaries:  o|o|o...|o|
        select num - 1 boundaries.(the last one is always the last slot: sum 'th)
        can NOT be repeated (no zero).
        - difference between boundaries (i.e. digits) should be increasing
        - diff btw boundaries should be btw 1 and 9
    - implementing:
        - arr: 0 to sum
        - choose array's repeated combinations of num - 1 out of sum + 1
        - add the last element (sum) to each selection
        - out of these, select the ones:
          - difference btw elements 0 to 9
          - difference btw elements increasing
          - build an array of unique admissible solutions
          - find length, min and max of the array
          - return

=end

def find_all(n, k)
  return [] if n > k * 9 || n < k
  arr = 1.upto(n).to_a
  combs = arr.combination(k - 1).to_a.map {|subar| subar + [n]}
  digits_arr = combs.map do |subar|
                k.times.map {|i| i>0 ? subar[i] - subar[i-1] : subar[i]}
              end
  solutions = digits_arr.select do |subar|
                subar.max <= 9
              end.select do |subar|
                (k-1).times.to_a.all? {|i| subar[i+1] >= subar[i] }
              end
  return [] if solutions.empty?
  [solutions.length, solutions.min.join.to_i, solutions.max.join.to_i]
end

# The above algorithm is not very efficient. Looking for something faster.

=begin

A more efficient algorithm:

  - find the maximum and minimum admissible values for each digit
  - form the cartesian product of all (min..max) intervals for each digit
  - choose the candidates that satisfy the sum and increseang order requirements
  - convert arrays to numbers (i.e. solution candidates)
  - return length, minimum and maximum

=end

def find_all(s, d) # s: sum, d: digits number
  arr_ranges = []
  1.upto(d) do |i| # i-th digit from left
    m = (1..9).find { |j| i * j + (d - i) * 9 >= s } # min
    n = (1..9).reverse_each.find { |j| (i - 1) + (d - i + 1) * j <= s } # max
    return [] if m.nil? or n.nil?
    arr_ranges << (m..n).to_a
  end
  candidates = arr_ranges.reduce do |arr, elm|
    arr.product(elm).map(&:flatten).select do |newar|
      newar.reduce(:+) <= s && newar == newar.sort
    end
  end # filtering for increasing combinations to avoid large # of candidates
  solutions = candidates.select do |arr|
              arr.reduce(:+) == s
            end #.map(&:join).map(&:to_i)
  [solutions.length, solutions.min.join.to_i, solutions.max.join.to_i]
end

# find_all(5, 3)
#
# p find_all(10, 3) == [8, 118, 334]
# p find_all(27, 3) == [1, 999, 999]
# p find_all(84, 4) == []
# p find_all(35, 6) == [123, 116999, 566666]
# p find_all(50, 10) == [1514, 1111199999, 5555555555] # takes about 1.5 seconds.

# borderline efficiency.

# faster solutino would be to use #repeated_combination (automatically sorted)
# and select the ones with the correct sum.

def find_all(s, d)
  sols = (1..9).to_a.repeated_combination(d).select {|arr| arr.reduce(:+) == s}
  return [] if sols.empty?
  [sols.length, sols.min.join.to_i, sols.max.join.to_i]
end

p find_all(10, 3) == [8, 118, 334]
p find_all(27, 3) == [1, 999, 999]
p find_all(84, 4) == []
p find_all(35, 6) == [123, 116999, 566666]
p find_all(50, 10) == [1514, 1111199999, 5555555555] # takes about 0.5 seconds.
