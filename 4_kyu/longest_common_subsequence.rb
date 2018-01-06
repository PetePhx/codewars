=begin

Write a function called LCS that accepts two sequences and returns the longest
subsequence common to the passed in sequences.

A subsequence is different from a substring. The terms of a subsequence need not
be consecutive terms of the original sequence.

Example subsequence

Subsequences of "abc" = "a", "b", "c", "ab", "ac", "bc" and "abc".
LCS examples

lcs( "abcdef" , "abc" ) => returns "abc"
lcs( "abcdef" , "acf" ) => returns "acf"
lcs( "132535365" , "123456789" ) => returns "12356"

Notes

    Both arguments will be strings
    Return value must be a string
    Return an empty string if there exists no common subsequence
    Both arguments will have one or more characters (in JavaScript)
    All tests will only have a single longest common subsequence.

=end

=begin
  - input: 2 strings
  - output: string: longest common subsequence (LCS)
  - algo:
    - turn strigns to arrays: arr1, arr2
    - Find common set of characters
      - common = arr1 & arr2
    - Remove characters that are not in common from both strings
      - arr1 &= common
      - arr2 &= common
    - loop over length of the shorter array, say arr1, in reverse
      - find subsequences of length k from arr1 (method #subseq)
      - check if a subsequence of arr2 (method #is_subsequence?)
      - return k if true

    - #is_subsequence(sub_arr, arr)
      - sub_arr -> map -> |elm| arr.index(elm) -> array of indices (arr_idx)
      - arr_idx == arr_idx.sort
=end

def subseqs(arr, k)
  arr.combination(k).to_a
end

def is_subseq?(subarr, arr)
  running_idx = 0
  subarr.each do |elm|
    return false unless arr[running_idx..-1].include?(elm)
    running_idx += arr[running_idx..-1].index(elm) + 1
  end
  return true
end

def lcs(x, y)
  arrs =  [x.chars, y.chars]
  common = arrs[0] & arrs[1]
  arrs.map! { |ar| ar.select { |elm| common.include? elm } }
  arrs.sort_by! { |ar| ar.length }
  arrs[0].length.downto(1) do |k|
    subseqs(arrs[0], k).each { |sq| return sq.join if is_subseq?(sq, arrs[1]) }
  end
  return ""
end

p is_subseq?([1,2,3], [1,2,3,4,5])
p is_subseq?([1,2,3], [3,1,2,3])
puts
p lcs("abcdef", "abca")
p lcs("a", "b")
p lcs("lhello", "ohello")
