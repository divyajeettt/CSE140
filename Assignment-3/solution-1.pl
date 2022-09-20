% edge(X, Y) can be directly represented as cost(X, Y, Z)
% which represents the edge from X to Y with path cost Z
cost(0, 1, 5).
cost(0, 6, 11).
cost(1, 2, 7).
cost(1, 5, 5).
cost(1, 6, 3).
cost(1, 7, 6).
cost(2, 3, -8).
cost(2, 5, -1).
cost(3, 4, 10).
cost(3, 5, 9).
cost(5, 4, 1).
cost(6, 5, 2).
cost(7, 6, 9).

% Keep track of children of a Node
children(0, [1, 6]).
children(1, [2, 5, 6]).
children(2, [3, 5]).
children(3, [4]).
children(4, []).
children(5, [3, 4]).
children(6, [5]).
children(7, [1, 6]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Helper function to Check if an item is present in a List
present(X, [X|_]).
present(X, [_|Tail]) :- present(X, Tail).

% Helper function to Concatenate two Lists
concatenate([], L, L).
concatenate([H|T1], L, [H|T2]) :- concatenate(T1, L, T2).

% Helper function to Reverse a List
reverse([X], [X]).
reverse([H|T], Answer) :- reverse(T, X), concatenate(X, [H], Answer).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% If current Node is the goal, set the Final Cost
depthFirstCost(Path, Node, Solution, CurrCost, FinalCost, Goal) :-
    Node == Goal,
    reverse([Node|Path], Solution),
    FinalCost is CurrCost.

% If it is not, then get the cost to each of its children one by one
% Sum the Costs and recursively call the function on the child
depthFirstCost(Path, Node, Solution, CurrCost, FinalCost, Goal) :-
    cost(Node, Child, C),
    not(present(Child, Path)),
    NewCost is CurrCost + C,
    depthFirstCost([Node|Path], Child, Solution, NewCost, FinalCost, Goal).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Queue implementation
enqueue(Queue, [], _, NewQueue) :- NewQueue = Queue.
enqueue(_, [Child], Visited, _) :- present(Child, Visited).

% Case: enqueue a single child which is not visited already
enqueue(Queue, [Child], Visited, NewQueue) :-
    not(present(Child, Visited)),
    concatenate(Queue, [Child], NewerQueue),
    NewQueue = NewerQueue,
    write(Child).

% Case: if current child has been visited, recursively call the function on rest of the list
enqueue(Queue, [Child|Rest], Visited, NewQueue) :-
    present(Child, Visited),
    enqueue(Queue, Rest, Visited, NewerQueue),
    NewQueue = NewerQueue.

% Case: if not, add it to the queue
enqueue(Queue, [Child|Rest], Visited, NewQueue) :-
    not(present(Child, Visited)),
    concatenate(Queue, [Child], NewerQueue),
    write(Child), write(', '),
    enqueue(NewerQueue, Rest, Visited, NewestQueue),
    NewQueue = NewestQueue.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% If the current node is the Goal, print it
breadthFirstSearch(Node, Goal, _, _) :-
    Goal == Node,
    write('Reached goal!').

% If it the first iteration, start the queue
breadthFirstSearch(Node, Goal, [], []) :-
    children(Node, Children),
    write(Node), write(': '),
    enqueue([], Children, [], NewQueue), nl,
    breadthFirstSearch(Node, Goal, NewQueue, [Node]).

% If the Dequeued Node is already visited, skip it
breadthFirstSearch(Node, Goal, [Dequeued|Rest], Visited) :-
    present(Dequeued, Visited),
    breadthFirstSearch(Node, Goal, Rest, Visited).

% If the Dequeued Node is not visited, enqueue its children and recursively call the function
breadthFirstSearch(_, Goal, [Dequeued|Rest], Visited) :-
    not(present(Dequeued, Visited)),
    children(Dequeued, Children),
    write(Dequeued), write(': '),
    enqueue(Rest, Children, Visited, NewQueue), nl,
    breadthFirstSearch(Dequeued, Goal, NewQueue, [Dequeued|Visited]).

% Handle Costs for total path - for each child of the node found in 'setof()', count the costs
handleCosts(Parent, Children, CurrCost, Child, NewQueue, NewCost) :-
    cost(Parent, Child, C),
    concatenate(Children, [Child], NewQueue),
    NewCost is CurrCost + C.

% If the current source list contains the Goal Node, the search has ended
breadthFirstCost(Source, [[Goal, Path, Cost]|_], Goal, Path, Cost) :-
    present(Goal, Source).

% If it is not, then get the cost to each of its children at once
% Recursively call the function on each child one by one
breadthFirstCost(Source, [[Node, Queue, CurrCost]|Rest], Goal, Path, Cost) :-
    setof(
        [Parent, Children, Costs],
        handleCosts(Node, Queue, CurrCost, Parent, Children, Costs),
        Children
    ),
    concatenate(Rest, Children, NextQueue),
    breadthFirstCost(Source, NextQueue, Goal, Path, Cost).

% setof(X, f(X, y), Result) returns the set-of all X such that
% the rule f(X, y) is True in the variable 'Result'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Call this function while executing
solveDepthFirst(Start, Goal, Solution, Cost) :-
    depthFirstCost([], Start, Solution, 0, Cost, Goal).

% Call this function while executing
solveBreadthFirst(Start, Goal, Path, Cost) :-
    breadthFirstSearch(Start, Goal, [], []),
    breadthFirstCost(_, [[Start, [Start], 0]], Goal, Path, Cost).
