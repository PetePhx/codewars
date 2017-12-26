=begin

Factorial Tail

Your task is to write a function, which will find the number of zeroes at the
end of (number) factorial in arbitrary radix = base for larger numbers.

    base is an integer from 2 to 256
    number is an integer from 1 to 1'000'000

=end

=begin
  - input: 2 integers, base (2-256), num (1-1000,000)
  - output: integer, number of zeros at the end of num! in base base.
  - algorithm:
    - require prime,
    - find the base prime division to prime factors:
      - [..., [p_i, n_i], ...] the i'th prime factor, power
    - for each p_i, get the sum of all p_i powers in 1..num: k_i
    - for each p_i, get k_i/n_i
    - return the minumum fof the array [ ..., k_i/n_i,...]
=end

require 'prime'

def zeroes(base, num)
  primes = base.prime_division
  arr = []
  primes.each do |p_i, n_i|
    max_pw = Math::log(num, p_i).to_i
    return 0 if max_pw == 0
    sum_i = 0
    1.upto(max_pw) do |pw|
      sum_i += num / p_i**pw
    end
    arr << sum_i / n_i
  end
  arr.min
end

p zeroes(10, 100) == 24
p zeroes(17, 16) == 0
p zeroes(7, 50) == 8
p zeroes(40, 10) == 2
p zeroes(100, 50) == 6
