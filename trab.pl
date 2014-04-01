:- dynamic pastelaria/2.
:- dynamic zona/2.
:- dynamic local/2.

pastelaria('diana').
pastelaria('mario').
pastelaria('mariana').
pastelaria('miguel').

zona('diana','centro').
zona('mario','sul').
zona('mariana','norte').
zona('miguel','norte').

local('diana',50,100).
local('mario',60,20).
local('mariana',80,160).
local('miguel',100,150).

sqrt(N,S) :- loop(N, 0, 1, 1, S).

loop(N, Sqrt, Odd, Sum, Ans) :-
        Sum =< N,
        Sqrt1 is Sqrt+1,
        Odd1 is Odd+2,
        Sum1 is Sum+Odd,
        loop(N, Sqrt1, Odd1, Sum1, Ans).

loop(N, Sqrt, _, Sum, Sqrt) :- Sum > N.

distancia(X,Y,A,B,R) :- R is sqrt(((X-A)*(X-A))+((Y-B)*(Y-B))).
