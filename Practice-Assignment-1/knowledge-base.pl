daughter(a, b).    /* B is the daughter of A */
daughter(a, c).    /* C is the daughter of A */
daughter(b, e).    /* E is the daughter of B */
daughter(e, j).    /* J is the daughter of E */
daughter(c, f).    /* F is the daughter of C */
daughter(m, n).    /* N is the daughter of M */
daughter(f, k).    /* K is the duaghter of F */

son(a, d).         /* D is the son of B */
son(d, h).         /* H is the son of D */
son(d, i).         /* I is the son of D */
son(c, g).         /* G is the son of C */
son(g, m).         /* M is the son of G */
son(f, l).         /* L is the son of F */

male(a).           /* Assumption */
male(d).
male(h).
male(i).
male(g).
male(m).
male(l).

female(b).
female(c).
female(e).
female(j).
female(f).
female(n).
female(k).

/* Defining relationships */

grandparent_grandson(X, Y) :-  (son(X, P), son(P, Y)); (daughter(X, P), son(P, Y)).
grandparent_granddaughter(X, Y) :- (son(X, P), daughter(P, Y)); (daughter(X, P), daughter(P, Y)).

grandfather_grandson(X, Y) :- grandparent_grandson(X, Y), male(X).
grandmother_grandson(X, Y) :- grandparent_grandson(X, Y), female(X).
grandfather_granddaughter(X, Y) :- grandparent_granddaughter(X, Y), male(X).
grandmother_granddaughter(X, Y) :- grandparent_granddaughter(X, Y), female(X).
