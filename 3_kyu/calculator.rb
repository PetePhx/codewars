=begin

Create a simple calculator that given a string of operators (+ - * and /) and
numbers separated by spaces returns the value of that expression

Example:

Calculator.new.evaluate("2 / 2 + 3 * 4 - 6") # => 7

Remember about the order of operations! Multiplications and divisions have a
higher priority and should be performed left-to-right. Additions and
subtractions have a lower priority and should also be performed left-to-right.

=end

=begin

- input: string
- output: integer: result of computation

- algorithm (no eval)
  - remove all white-space characters
    exps = str.gsub(/\s/,'')
  - break the expression to sub-expressions
    - exps = str.split(/(\+|\-)/)
  - loop through sub-expressions
    - if "+" or "-", do nothing
    - else, invoke sub_eval(subexp), substitute in the array
  - invoke sub_eval on array.join

=end

class Calculator
  def evaluate(str)
    exps = str.split(/(\+|\-)/)
    eval(exps.map { |str| %w[+ -].include?(str) ? str : eval(str) }.join)
  end
end

# eval is disabled for this kata. Strangely, it accepts instance_eval. We will
# do it the hard way.

class Calculator
  def evaluate(str)
    exps = str.gsub(/\s/, '').split(/(\+|\-)/)
    subeval(exps.map { |exp| %[+, -].include?(exp) ? exp : subeval(exp)}.join)
  end

  def subeval(subexp)
    arr = subexp.split(/(\*|\/|\%|\+|\-)/)
    result, op = 1, :*
    arr.each do |i|
      i.to_i.to_s == i ? result = result.send(op, i.to_i) : op = i.to_sym
    end
    result
  end
end

# p Calculator.new.subeval("10*2")
# p Calculator.new.evaluate("20 / 20 + 3 * 4 - 6") # 7

p Calculator.new.evaluate("10 * 5 / 2")
p Calculator.new.subeval("10*5/2")
