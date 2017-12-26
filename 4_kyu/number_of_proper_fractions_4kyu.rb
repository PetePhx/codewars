=begin

If n is the numerator and d the denominator of a fraction, that fraction is
defined a (reduced) proper fraction if and only if GCD(n,d)==1.

For example 5/16 is a proper fraction, while 6/16 is not, as both 6 and 16 are
divisible by 2, thus the fraction can be reduced to 3/8.

Now, if you consider a given number d, how many proper fractions can be built
using d as a denominator?

For example, let's assume that d is 15: you can build a total of 8 different
proper fractions between 0 and 1 with it: 1/15, 2/15, 4/15, 7/15, 8/15, 11/15,
13/15 and 14/15.

You are to build a function that computes how many proper fractions you can
build with a given denominator:

proper_fractions(1)==0
proper_fractions(2)==1
proper_fractions(5)==4
proper_fractions(15)==8
proper_fractions(25)==20

Be ready to handle big numbers.

=end

=begin
- input: integer (m)
- output: integer: number of proper fractions m/n between 0 and 1
    (exclusive of 0 and 1)
  - i.e. numbers from 1 to n-1 that are prime relative to n
- rules: should be able to handle large numbers (not just running gcd on every
      number)
- algorithm:
  - find all prime divisors of n, build an array (arr). length: l
  - initialize num to n - 1
  - for k from 1 to l
    - take k divisors out of l,
    - multiply them, divide into n, minus one
    - for odd k, subtract from num, for even k, add
  - return num
=end

require 'prime'

def proper_fractions(n)
  return 0 if n < 2
  pr_arr = n.prime_division.transpose[0]
  sz = pr_arr.size
  num_rel_pr = n - 1
  1.upto(sz) do |k|
    pr_arr.combination(k).to_a.each do |com_arr|
      factor = com_arr.reduce(:*)
      num_fac = (n / factor) - 1
      num_rel_pr -= (k.odd? ? num_fac : -num_fac)
    end
  end
  num_rel_pr
end

p proper_fractions(15)


p proper_fractions(1)==0
p proper_fractions(2)==1
p proper_fractions(5)==4
p proper_fractions(15)==8
p proper_fractions(25)==20
