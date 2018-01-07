=begin

Complete the function/method (depending on the language) to return true/True
when its argument is an array that has the same nesting structure as the first
array.

For example:

# should return true
[ 1, 1, 1 ].same_structure_as( [ 2, 2, 2 ] )
[ 1, [ 1, 1 ] ].same_structure_as( [ 2, [ 2, 2 ] ] )

# should return false
[ 1, [ 1, 1 ] ].same_structure_as( [ [ 2, 2 ], 2 ] )
[ 1, [ 1, 1 ] ].same_structure_as( [ [ 2 ], 2 ] )

# should return true
[ [ [ ], [ ] ] ].same_structure_as( [ [ [ ], [ ] ] ] );

# should return false
[ [ [ ], [ ] ] ].same_structure_as( [ [ 1, 1 ] ] )

=end

class Array
  def same_structure_as(other)
    return false unless other.is_a?(Array)
    self.nesting_struc == other.nesting_struc
  end

  def nesting_struc
    @str = self.to_s.gsub(/("[^"]")/,'').delete("^[],")
  end
end

# should return true
p [ 1, 1, 1 ].same_structure_as( [ 2, 2, 2 ] ) == true
p [ 1, [ 1, 1 ] ].same_structure_as( [ 2, [ 2, 2 ] ] ) == true

# should return false
p [ 1, [ 1, 1 ] ].same_structure_as( [ [ 2, 2 ], 2 ] ) == false
p [ 1, [ 1, 1 ] ].same_structure_as( [ [ 2 ], 2 ] ) == false

# should return true
p [ [ [ ], [ ] ] ].same_structure_as( [ [ [ ], [ ] ] ] ) == true

# should return false
p [ [ [ ], [ ] ] ].same_structure_as( [ [ 1, 1 ] ] ) == false

# should return true
p [ ",", ",", "," ].same_structure_as( [ 2, 2, 2 ] ) == true
