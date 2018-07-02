/*
IRV

Your task is to implement a function that calculates an election winner from a list of voter selections using an Instant Runoff Voting algorithm. If you haven't heard of IRV, here's a basic overview (slightly altered for this kata):

  Each voter selects several candidates in order of preference.
  The votes are tallied from the each voter's first choice.
  If the first-place candidate has more than half the total votes, they win.
  Otherwise, find the candidate who got the least votes and remove them from each person's voting list.
  In case of a tie for least, remove all of the tying candidates.
  In case of a complete tie between every candidate, return nil(Ruby)/None(Python)/undefined(JS).
  Start over.
  Continue until somebody has more than half the votes; they are the winner.

Your function will be given a list of voter ballots; each ballot will be a list of candidates (symbols) in descending order of preference. You should return the symbol corresponding to the winning candidate. See the default test for an example!

*/

/*
- input: array of arrays: list of candidates for each voter
- output: IRV result

- algorithm:
  - build a list of all avalable candidates
    - run a loop:
      - get a tally of all first choices, (including 0), store in a tally object
      - if a choice has 50%+, return it
      - find the choice with minimum votes in the tally
      - remove it from all the lists
    - return `undefined`

*/

function runoff(voters){
  var lists = voters.map(arr => arr.slice()); // copy voters so as not to mutate inputs
  var len = lists.length;
  var tally = {};
  var candMaj;
  var minVotes;

  do {
    tally = runTally(lists);
    candMaj = Object.entries(tally).filter(pair => pair[1] > len / 2); //  candidate with majority vote?
    if (candMaj.length > 0) return candMaj[0][0];                    // then return it. otherwise:
    minVotes = Math.min(...Object.values(tally));                    // least votes
    candMin = Object.keys(tally).filter(k => tally[k] === minVotes); // least popular candidate(s)
    if (candMin.length > 0) removeCands(lists, candMin);
  } while (lists.map(arr => arr.length).some(val => val > 0));         // while at least one non-empty list

  return undefined;
}

function runTally(lists) {
  var tally = {};
  lists.forEach(lst => lst.forEach(elm => tally[elm] = 0)); // generate keys in the object
  lists.forEach(lst => { if (lst[0]) tally[lst[0]] += 1; });                 // first choice votes
  return tally;
}

function removeCands(lists, cands) {
  for (var i = 0; i < lists.length; i++) {
    for (var j = 0; j < cands.length; j++) {
      while (lists[i].includes(cands[j])) { lists[i].splice(lists[i].indexOf(cands[j]), 1); }
    }
  }
  return lists;
}

// console.log(removeCands([[1, 2], [2, 3], [3, 4], [2, 5]], [5, 2]));

console.log(runoff([["d", "a", "e", "b", "c"],
                    ["b", "e", "d", "c", "a"],
                    ["e", "a", "c", "b", "d"],
                    ["e", "d", "a", "b", "c"],
                    ["d", "b", "a", "e", "c"]])); // "e"
