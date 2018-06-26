/*
Write a function toWeirdCase (weirdcase in Ruby) that accepts a string, and returns the same string with all even indexed characters in each word upper cased, and all odd indexed characters in each word lower cased. The indexing just explained is zero based, so the zero-ith index is even, therefore that character should be upper cased.

The passed in string will only consist of alphabetical characters and spaces(' '). Spaces will only be present if there are multiple words. Words will be separated by a single space(' ').
Examples:

toWeirdCase( "String" );//=> returns "StRiNg"
toWeirdCase( "Weird string case" );//=> returns "WeIrD StRiNg CaSe"
*/

/*
- input: string consisting or words separated by white-space
- output: string with the words converted to WeIrD-CaSe

- Algorithm:
  - split the string to arrays of words
    - split each word to an array of characters
      -  map the array or chars to upper/lower case based on idx % 2
    - join the characters to make words
  - join the words to make sentence
  - return the new string
*/

function toWeirdCase(str) {
  return str.split(' ')
            .map(wrd => wrd.split(''))
            .map(wrdArr => wrdArr.map((c, idx) => idx % 2 === 0 ? c.toUpperCase() : c.toLowerCase())
            .join(''))
            .join(' ');
}
