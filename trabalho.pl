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

%coordenadas(cod_coor,coor_X,coor_Y)
coordenadas(coor1,100,100).
coordenadas(coor2,80,60).

%tipo(cod_tipo,nome).
tipo(0, sem_takeAway).
tipo(1, takeAway).

%regiao(cod_regiao, nome_regiao).
regiao(n,norte).
regiao(c,centro).
regiao(s,sul).

%localidade(nome_loc,cod_regiao).
localidade(braga, n).

%restaurante(nome_rest, nome_loc, cod_tipo, cod_coor).
restaurante(atum,braga,1,coor1).
restaurante(bacalhau,porto,0,coor2).

sqrt(N,S) :- loop(N, 0, 1, 1, S).

loop(N, Sqrt, Odd, Sum, Ans) :-
        Sum =< N,
        Sqrt1 is Sqrt+1,
        Odd1 is Odd+2,
        Sum1 is Sum+Odd,
        loop(N, Sqrt1, Odd1, Sum1, Ans).

loop(N, Sqrt, _, Sum, Sqrt) :- Sum > N.

distancia(X,Y,A,B,R) :- R is sqrt(((X-A)*(X-A))+((Y-B)*(Y-B))).

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