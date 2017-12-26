=begin

Write a function deNico/de_nico() that accepts two parameters:

    key/$key - string consists of unique letters and digits
    message/$message - string with encoded message

and decodes the message using the key.

First create a numeric key basing on the provided key by assigning each letter
position in which it is located after setting the letters from key in an
alphabetical order.

For example, for the key crazy we will get 23154 because of acryz (sorted
letters from the key).

Let's decode cseerntiofarmit on using our crazy key.

1 2 3 4 5
---------
c s e e r
n t i o f
a r m i t
  o n

After using the key:

2 3 1 5 4
---------
s e c r e
t i n f o
r m a t i
o n

Notes

    The message is never shorter than the key.
    Don't forget to remove trailing whitespace after decoding the message

Examples

deNico("crazy", "cseerntiofarmit on  ") => "secretinformation"
deNico("abc", "abcd") => "abcd"
deNico("ba", "2143658709") => "1234567890"
deNico("key", "eky") => "key"

=end

=begin
- input: key phrase string, enciphered string
- output: deciphered string
- algorithm
  - use the key to find the permutation index
  - chop the string to blocks of the size of permutatino
  - appy permutation to each block, join them together, return
=end

def find_perm(key_str)
  key_arr = key_str.chars
  sorted_arr = key_arr.sort
  permut = key_arr.size.times.to_a.permutation.select do |perm|
    sorted_arr.values_at(*perm) == key_arr
  end.flatten
end

def de_nico(key, str)
  perm = find_perm(key)
  sz = key.size
  rem = str.length % key.length
  str += '*' * (-rem % key.length)
  blocks_arr = str.scan(/.{#{sz}}/)
  deciph_arr = blocks_arr.map { |str| str.chars.values_at(*perm).join('')}
  deciph_str = deciph_arr.join('').delete('*').rstrip
end

p find_perm('ohcfltpb')

p de_nico("crazy", "cseerntiofarmit on  ") == "secretinformation"
p de_nico("crazy","cseerntiofarmit on") == "secretinformation"
p de_nico("abc", "abcd") == "abcd"
p de_nico("ba", "2143658709") == "1234567890"
p de_nico("key", "eky") == "key"
p de_nico("kcrblh", "byzfi atz") == "fy biztaz"
p de_nico("ohcfltpb", "xwvgpllbfcx") == "lgwvpblxcxf"
