=begin

In a grid of 4 by 4 squares you want to place a skyscraper in each square with
only some clues:

    The height of the skyscrapers is between 1 and 4
    No two skyscrapers in a row or column may have the same number of floors
    A clue is the number of skyscrapers that you can see in a row or column from
      the outside
    Higher skyscrapers block the view of lower skyscrapers located behind them


Can you write a program that can solve this puzzle?

Example:

To understand how the puzzle works, this is an example of a row with 2 clues.
Seen from the left side there are 4 buildings visible while seen from the right
side only 1:

 4 	     	     	     	     	 1

There is only one way in which the skyscrapers can be placed. From left-to-right
all four buildings must be visible and no building may hide behind another
building:

 4 	 1 	 2 	 3 	 4 	 1

Example of a 4 by 4 puzzle with the solution:

	   	     	 1 	 2

   	   	   	   	   	 2
 1

   	   	   	 3

solution:
   	   	   	 1 	 2
   	 2 	 1 	 4 	 3
   	 3 	 4 	 1 	 2 	 2
 1 	 4 	 2 	 3 	 1
   	 1 	 3 	 2 	 4
   	   	   	 3

Task:

    Finish:

def solve_puzzle(clues)

  Pass the clues in an array of 16 items. This array contains the clues around
  the clock, index:

     	 0 	 1 	  2 	 3
   15 	   	   	   	   	 4
   14 	   	   	   	   	 5
   13 	   	   	   	   	 6
   12 	   	   	   	   	 7
     	11 	10   	9 	 8

  If no clue is available, add value 0
  Each puzzle has only one possible solution
  SolvePuzzle() returns matrix int[][]. The first indexer is for the row, the
  second indexer for the column. (Python: returns 4-tuple of 4-tuples, Ruby:
  4-Array of 4-Arrays)

If you finished this kata you can use your solution as a base for the more
challenging kata: 6 By 6 Skryscrapers

=end

=begin

-algorithm
  - define lcount and rcount methods:
      count the number of visible skyscrapers from left and right
  - define #check_clues(clues, matrix) to check the counts for all rows/columns
  - define #solve_puzzle(clues) method
    - iterate over combinations of all permutations for the 4 rows (24 each)
      - ensure all columns have each 4 distinct numbers
        mat.transpose.map(&:sum) = [[1,2,3,4]] * 4
      - if a solution satisfies the #check_clues condition, return it.

=end

def lcount(arr)
  (1...arr.length).reduce(1) { |c, i| arr[i] > arr[0...i].max ? c + 1 : c }
end

def rcount(arr)
  lcount(arr.reverse)
end

p lcount([1, 2, 3, 4]) # 4
p lcount([2, 1, 4, 3]) # 2
p lcount([4, 1, 3, 2]) # 1
puts
p rcount([1, 2, 3, 4]) # 1
p rcount([2, 1, 4, 3]) # 2
p rcount([4, 1, 3, 2]) # 3

def check_clues(clues, mat)
  (0...4).map { |i| clues[i].zero? || lcount(mat.transpose[i]) == clues[i] }.reduce(:&) &&
  (4...8).map { |i| clues[i].zero? || rcount(mat[i - 4]) == clues[i] }.reduce(:&) &&
  (8...12).map { |i| clues[i].zero? || rcount(mat.transpose[11 - i]) == clues[i] }.reduce(:&) &&
  (12...16).map { |i| clues[i].zero? || lcount(mat[15 - i]) == clues[i] }.reduce(:&)
end

clues = [3, 0, 1, 2, 0, 2, 0, 0, 0, 3, 0, 0, 0, 1, 0, 0]
matrix = [ [2, 1, 4, 3],
           [3, 4, 1, 2],
           [4, 2, 3, 1],
           [1, 3, 2, 4] ]
puts
p check_clues(clues, matrix)

def solve_puzzle(clues)
  [1,2,3,4].permutation.to_a.permutation(4).to_a.each do |mat|
    return mat if mat.transpose.map(&:sort) == [[1,2,3,4]] * 4 &&
                    check_clues(clues, mat)
  end
end

p solve_puzzle(clues)
# [[2, 1, 4, 3], [3, 4, 1, 2], [4, 2, 3, 1], [1, 3, 2, 4]]


clues = clues    = [0, 0, 1, 2,
                    0, 2, 0, 0,
                    0, 3, 0, 0,
                    0, 1, 0, 0]
p solve_puzzle(clues)
# [[2, 1, 4, 3], [3, 4, 1, 2], [4, 2, 3, 1], [1, 3, 2, 4]]
