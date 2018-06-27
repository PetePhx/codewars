/*
You need to write regex that will validate a password to make sure it meets the following criteria:

    At least six characters long
    contains a lowercase letter
    contains an uppercase letter
    contains a number

Valid passwords will only be alphanumeric characters.
*/

/*

start:         ^
lowercase:    (?=.*[a-z])
uppercase:    (?=.*[A-Z])
number:       (?=.*\d)
Only alphanum: ((?!.*[^a-zA-Z0-9]))
length > 6:   .{6,}
end:          $
*/

function validate(password) {
  return /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?!.*[^a-zA-Z0-9]).{6,}$/.test(password);
}

// alternatively:

function validate(password) {
  return /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z0-9]{6,}$/.test(password);
}
