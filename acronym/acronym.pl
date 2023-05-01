% Convert string sentence to string acronym
% String -> String
abbreviate(Sentence, Acronym) :-
    % Find List of words that concatenate to given sentence
    atomic_list_concat(
        SentenceWords1, % Result
        ' ',  % Separator
        Sentence  % Input
    ),

    % Split any hyphenated words in the List
    maplist(split_hyphenated, SentenceWords1, SentenceWords2),
    % and flatten the List again
    flatten(SentenceWords2, SentenceWords),

    % Find List of first letters of given List of words
    do_abbreviate(
        SentenceWords,  % Input
        AcronymLetters  % Result
    ),

    % Concatenate List of characters
    atomic_list_concat(
        AcronymLetters,  % Input
        AcronymAtom  % Result
    ),

    % Convert Atom -> uppercase String
    atom_string(AcronymAtom, AcronymString),
    string_upper(AcronymString, Acronym).

% Convert each word of sentence to one letter
% List -> List
do_abbreviate([FirstWord|SentenceTail], [FirstLetter|AcronymTail]) :-
    % Split first word into characters
    atom_chars(
        FirstWord,  % Input
        WordCharacters  % Result
    ),

    % Bind first alphabetic character in the word to the list of letters
    first_alpha(WordCharacters, FirstLetter),

    % Recursively abbreviate the tail
    do_abbreviate(
        SentenceTail,  % Input
        AcronymTail  % Result
    ).

% End recursion when Lists exhausted
do_abbreviate([], []).

% Find first alphabetic character in list of characters
first_alpha([FirstCharacter|CharactersTail], FirstAlpha) :-
    char_type(FirstCharacter, alpha) ->
        FirstAlpha = FirstCharacter ;
        first_alpha(CharactersTail, FirstAlpha).

% End recursion when List exhausted - bind an empty string
first_alpha([], FirstAlpha) :-
    FirstAlpha = ''.

% Split a hyphenated word into a list of its parts
split_hyphenated(Word, WordParts) :-
    % Find list of words that form hyphenated word
    atomic_list_concat(
        WordParts, % Result
        '-',  % Separator
        Word  % Input
    ).
