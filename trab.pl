%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais
:- op( 900,xfy,'::' ).
:- dynamic '-'/1.
:- dynamic pastelaria/1.
:- dynamic zona/2.
:- dynamic local/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado pastelaria: Nome -> {V,F}

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de conhecimento inicial

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

sqrt(N,S) :- S is N*N.

distancia((X1,Y1),(X2,Y2),R) :- R is sqrt(((X1-X2)*(X1-X2))+((Y1-Y2)*(Y1-Y2))).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que não permite a insercao de conhecimento repetido

+pastelaria( P ) :: (solucoes( P, (pastelaria( P )), S),
					comprimento( S,N ), N==1
					).

-pastelaria( P ) :: (
					).

-zona( P,R ) :- nao(zona( P,R )).
-local( P,XX,YY ) :- nao(local( P,XX,YY )).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a remocao do conhecimento

remocao( Termo ) :-
 	solucoes( Invariante,-Termo::Invariante,Lista ),
 	teste( Lista ),
    remover( Termo ).

remover( Termo ) :-
	retract( Termo ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a evolucao do conhecimento

evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

insercao( Termo ) :-
	assert( Termo ).
insercao( Termo ) :-
	retract( Termo ),!,fail.

teste( [] ).
teste( [A|B] ) :-
	A,
	teste( B ).

solucoes( X,Y,Z ) :-
	findall( X,Y,Z ).

comprimento( S,N ) :-
	length( S,N ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao(X) :- X,!,fail.
nao(X).