/*
Count the number of Duplicates

Write a function that will return the count of distinct case-insensitive alphabetic characters and numeric digits that occur more than once in the input string. The input string can be assumed to contain only alphabets (both uppercase and lowercase) and numeric digits.
Example

"abcde" -> 0 # no characters repeats more than once
"aabbcde" -> 2 # 'a' and 'b'
"aabBcde" -> 2 # 'a' occurs twice and 'b' twice (bandB)
"indivisibility" -> 1 # 'i' occurs six times
"Indivisibilities" -> 2 # 'i' occurs seven times and 's' occurs twice
"aA11" -> 2 # 'a' and '1'
"ABBA" -> 2 # 'A' and 'B' each occur twice
*/

/*
- input: string of alphanumerics
- output: integer: count of characters (case-insensitive) that are repeated

- Algorithm:
  - toLowerCase() the string
  - convert string to array,
  - sort array
  - remove elements that have count of 1
  - back to string
  - collapse repeated characters
  - return the length of the string
*/

function duplicateCount(str){
  return str.toLowerCase()
            .split('')
            .sort()
            .filter((e, _, ary) => ary.indexOf(e) < ary.lastIndexOf(e))
            .join('')
            .replace(/(.)\1+/g, '$1')
            .length;
}

duplicateCount("abcde"); //-> 0 # no characters repeats more than once
duplicateCount("aabbcde"); //-> 2 # 'a' and 'b'
duplicateCount("aabBcde"); //-> 2 # 'a' occurs twice and 'b' twice (bandB)
duplicateCount("indivisibility"); //-> 1 # 'i' occurs six times
duplicateCount("Indivisibilities"); //-> 2 # 'i' occurs seven times and 's' occurs twice
duplicateCount("aA11"); //-> 2 # 'a' and '1'
duplicateCount("ABBA"); //-> 2 # 'A' and 'B' each occur twice
