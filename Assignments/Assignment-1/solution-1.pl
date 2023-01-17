/* Part a) Check if Student P is present at Position U in row */
present_at(P, [P|_], 1).
present_at(P, [_|T], U):- X is U-1, present_at(P, T, X).

/* OR
 * present_at(P, [H|T], U):- (P is H, U is 1); (X is U-1, present_at(P, T, X)). */

/* Part b): Find the length of the row */
row_length([], 0).
row_length([_], 1).
row_length([_|T], X):- row_length(T, S), X is S+1.
