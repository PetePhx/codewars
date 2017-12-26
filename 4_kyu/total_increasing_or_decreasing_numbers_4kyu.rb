=begin

Let's define increasing numbers as the numbers whose digits, read from left to
right, are never less than the previous ones: 234559 is an example of increasing
number.

Conversely, decreasing numbers have all the digits read from left to right so
that no digits is bigger than the previous one: 97732 is an example of
decreasing number.

You do not need to be the next Gauss to figure that all numbers with 1 or 2
digits are either increasing or decreasing: 00, 01, 02, ..., 98, 99 are all
belonging to one of this categories (if not both, like 22 or 55): 101 is indeed
the first number which does NOT fall into either of the categories. Same goes
for all the numbers up to 109, while 110 is again a decreasing number.

Now your task is rather easy to declare (a bit less to perform): you have to
build a function to return the total occurrences of all the increasing or
decreasing numbers below 10 raised to the xth power (x will always be >= 0).

To give you a starting point, there are a grand total of increasing and
decreasing numbers as shown in the table:

Total 	Below
1 	1
10 	10
100 	100
475 	1000
1675 	10000
4954 	100000
12952 	1000000

=end

=begin
-algorithm:
  - given x digits:
  - for each repeated_combination of (1..9) with x digits:
    - there is the increasing and decreasing order of digits => 2 numbers
    - in the special case that all digits are the same, we only get one number
  - for any x digit number, there are 9 combinations with all digits the same:
    - 111...1, 222...2, ..., 999...9
  - take into account the numbers that have k zeros: only 1 combination:
    (0, 4, 5) => 540
  - 045 or 45 is already counted in previous iteration. just add them.
=end

def rep_com_num(n, k)
  (1...(n+k)).reduce(:*)/(1..k).reduce(:*)/(1...n).reduce(:*)
end

def total_inc_dec(x)
  1.upto(x).map do |y|
    rep_com_num(9, y) * (x - y + 2) - 9
  end.reduce(0, :+) + 1
end

p total_inc_dec(0) # == 1
p total_inc_dec(1) # == 10
p total_inc_dec(2) # == 100
p total_inc_dec(3) # == 475
p total_inc_dec(4) # == 1675
p total_inc_dec(5) # == 4954
p total_inc_dec(6) # == 12952
