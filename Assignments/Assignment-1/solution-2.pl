/* INPUT = [3, 5, 1, 4, 0, 2]. */
/* ANS = [3, 5+3, 1+5+3, 4+1+5+3, 0+4+1+5+3, 2+0+4+1+5+3]. */

/* Approach:-
 * Input = [1, 2, 3, 4]
 * Step-1 = [4, 3, 2, 1]
 * Step-2 = [4+sum(3, 2, 1), 3+sum(2, 1), 2+sum(1), 1]
 *        = [10, 6, 3, 1]
 * Step-3 = [1, 3, 6, 10] */

concatenate([], L, L).
concatenate([H|T1], L, [H|T2]):- concatenate(T1, L, T2).

reverse([], []).
reverse([X], [X]).
reverse([H|T], P):- reverse(T, X), concatenate(X, [H], P).

sum([], 0).
sum([H|T], X):- sum(T, P), X is H+P.

update_1([X], [X]).
update_1([H|T], [X|Y]):- sum([H|T], X), update_1(T, Y).

/* Final function to be called */
update_2(L, X):- reverse(L, Rev), update_1(Rev, New), reverse(New, X).
