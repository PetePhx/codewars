=begin

You'll get an entered term (lowercase string) and an array of known words (also
lowercase strings). Your task is to find out, which word from the dictionary is
most similar to the entered one. The similarity is described by the minimum
number of letters you have to add, remove or replace in order to get from the
entered word to one of the dictionary. The lower the number of required changes,
the higher the similarity between each two words.

Same words are obviously the most similar ones. A word that needs one letter to
be changed is more similar to another word that needs 2 (or more) letters to be
changed. E.g. the mistyped term berr is more similar to beer (1 letter to be
replaced) than to barrel (3 letters to be changed in total).

Extend the dictionary in a way, that it is able to return you the most similar
word from the list of known words.

Code Examples:

fruits = new Dictionary(['cherry', 'pineapple', 'melon', 'strawberry',
          'raspberry']);
fruits.findMostSimilar('strawbery'); // must return "strawberry"
fruits.findMostSimilar('berry'); // must return "cherry"

things = new Dictionary(['stars', 'mars', 'wars', 'codec', 'codewars']);
things.findMostSimilar('coddwars'); // must return "codewars"

languages = new Dictionary(['javascript', 'java', 'ruby', 'php', 'python',
              'coffeescript']);
languages.findMostSimilar('heaven'); // must return "java"
languages.findMostSimilar('javascript'); // must return "javascript"
(same words are obviously the most similar ones)

Additional notes:

    there is always exactly one possible solution

=end

=begin
  -input
  -output

  - algorithm:
    - define a distance function
      - return the distance between two words
      - minumum number of changes for one word to become the other
        - changes are:
          - insertion
          - deletion
          - replacement

      -strategy:
        -loop over k, where k is the number of operations (del/ins/rep)
          -from zero of length of the longer word
          - number of ins minus number of del should be == length2 - length1

      - method #can_reach_in_steps?(arr1, arr2, k)
        - can we get from arr1 to arr2 in k operations (del, replace, insert)?
        - sort in increasing length. arr1.length <= arr2.length
        - calculate number of ins_less_del (insertions minus deletions)
          - length2 - length1

        - efficient looping:
          - delettion number is from 0 upto (k - ins_less_del) / 2 (del)
          - replacement number (rep) is k - del - ins
          - insertion number (ins) is dels + ins_less_del
          - rules for del/rep/ins:
            - replace only to elements present in arr2
            - insert only elements present in arr2

  Problem: code takes too long to run. Have to find a smarter way of manipulating
            arrays to get from one to another.

           perhaps use code from LCS : longest common subsequence?
=end

class Dictionary
  def initialize(words)
    @words=words.sort_by { |w| w.length }
    @maxlength = words.map { |w| w.length }.max unless words.nil? || words.empty?
  end

  def find_most_similar(term)
    0.upto([term.length, @maxlength].max) do |k|
      @words.each { |w| return w if can_reach_in_steps?(w.chars, term.chars, k) }
    end
  end

  def can_reach_in_steps?(arr1, arr2, k)
    arr1, arr2 = [arr1, arr2].sort_by { |arr| arr.length }
    return false if ((ins_less_del = arr2.length - arr1.length) > k)
    0.upto((k - ins_less_del) / 2) do |dels| # dels deletions
      del_arrs = deletion(arr1, dels)
      # k - dels - ins replacements
      rep_arrs = del_arrs.map { |arr| replacement(arr, k - ins_less_del - dels, arr2) }
                   .flatten(1)
      # ins_less_del + dels insertions
      ins_arrs = rep_arrs.map { |arr| insertion(arr, ins_less_del + dels, arr2) }
                   .flatten(1)
      return true if ins_arrs.any? {|arr| arr == arr2 }
    end
    false
  end

  def deletion(arr, k)
    (0...arr.length).to_a.combination(k).map do |idx_arr|
      arr.reject.with_index { |_, idx| idx_arr.include?(idx) }
    end
  end

  def replacement(arr, k, set_arr)
    (0...arr.length).to_a.combination(k).map do |idx_arr|
      # k replacements at idx_arr positions, chosen from set_arr
      out = []
      set_arr.repeated_permutation(k) do |new_arr|
        inx = -1
        out << (0...arr.length).map { |idx| idx_arr.include?(idx) ? new_arr[(inx += 1)] : arr[idx] }
      end
      out
    end.flatten(1)
  end

  def insertion(arr, k, set_arr)
    (0...(arr.length + k)).to_a.repeated_combination(k).map do |idx_arr|
      # k insertions at idx_arr positions, chosen from set_arr
      out = []
      set_arr.repeated_permutation(k) do |new_arr|
        arr_d = arr.dup
        idx_arr.zip(new_arr).reverse_each { |idx, elm| arr_d.insert(idx, elm) }
        out << arr_d
      end
      out.uniq
    end.flatten(1)
  end
end

p Dictionary.new(nil).can_reach_in_steps?("abc", "c", 1) # false

p Dictionary.new(nil).deletion([1,2,3,4], 2)
# [[3, 4], [2, 4], [2, 3], [1, 4], [1, 3], [1, 2]]

p Dictionary.new(nil).replacement([2,2,2,2], 1, [0,1])
# [ [0, 2, 2, 2], [1, 2, 2, 2], [2, 0, 2, 2], [2, 1, 2, 2], [2, 2, 0, 2],
#   [2, 2, 1, 2], [2, 2, 2, 0], [2, 2, 2, 1] ]

p Dictionary.new(nil).insertion([2,2,2], 0, [0,1]) # [[2, 2, 2]]

p Dictionary.new(nil).can_reach_in_steps?([2,2,2], [2,2,2], 0) # true

p Dictionary.new(nil).can_reach_in_steps?([2,2,2], [2,2], 1) # true

p Dictionary.new(nil).can_reach_in_steps?([2,2,2], [2, 0, 2], 1) # true

p Dictionary.new(nil).can_reach_in_steps?([2,2,2], [2, 0, 0], 1) # false

p Dictionary.new(['hi', 'hello']).find_most_similar('hi') # 'hi'

p Dictionary.new(['hi', 'hello']).find_most_similar('hello') # 'hello'

p Dictionary.new(['hi', 'hello']).find_most_similar('mello') # 'hello'

p Dictionary.new(['hi', 'hello']).find_most_similar('hire') # 'hi'
