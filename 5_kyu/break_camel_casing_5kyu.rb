=begin

Complete the solution so that the function will break up camel casing, using a space between words.
Example

solution('camelCasing') # => should return 'camel Casing'

=end

=begin
- algorithm
  - find all occurences of small letter followed by a capital letter
  - insert a space in between
=end


def solution(str)
  str.gsub(/([a-z])([A-Z])/,'\1 \2')
end

p solution('camelCasing') == 'camel Casing'
