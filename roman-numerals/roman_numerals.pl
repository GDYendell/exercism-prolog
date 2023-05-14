convert(Number, Numeral) :-
    convertAcc(Number, "", Numeral).

convertAcc(0, Numeral, Numeral).
convertAcc(Number, Acc, Numeral) :-
    % Subtract a roman numeral
    subtractRoman(Number, NumeralPart, Difference),
    % Append numeral
    string_concat(Acc, NumeralPart, NewAcc),
    % Continue until 0
    convertAcc(Difference, NewAcc, Numeral).

% Subtract the highest roman numeral without going negative
subtractRoman(Number, Numeral, Difference) :-
    % Lookup roman numeral to number mappings (from highest to lowest)
    roman(NumeralValue, Numeral),
    % Check it can be subtracted
    Number >= NumeralValue,
    % Subtract
    Difference is Number - NumeralValue.

% Roman numeral rules
roman(1000, "M").
roman(900, "CM").
roman(500, "D").
roman(400, "CD").
roman(100, "C").
roman(90, "XC").
roman(50, "L").
roman(40, "XL").
roman(10, "X").
roman(9, "IX").
roman(5, "V").
roman(4, "IV").
roman(1, "I").
