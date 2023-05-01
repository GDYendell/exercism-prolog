isogram(Word) :-
    % Isogramness is case-insensitive - make sure all uppercase
    string_upper(Word, WordUpper),
    % Create list of characters from word
    string_chars(WordUpper, Characters),
    % Only include letters
    include(is_alpha, Characters, Letters),
    % Check for duplicates
    check_set(Letters).

% Check if a list is also a set
check_set([Head|Tail]) :-
    % Check if Head is in Tail, i.e. there is a duplicate
    memberchk(Head, Tail) ->
        % If Head appears again in Tail, there is a duplicate so list is not a set
        false ;
        % If not, continue checking Tail
        check_set(Tail).

% End recursion - no duplicates found so list is a set
check_set([]).
