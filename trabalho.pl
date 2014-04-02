%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais
:- op( 900,xfy,'::' ).
:- dynamic '-'/1.
:- dynamic restaurante/4.
:- dynamic tipo/2.
:- dynamic coordenadas/3.
:- dynamic regiao/2.
:- dynamic localidade/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado restaurante: Nome -> {V,F}

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de conhecimento inicial

% coordenadas(cod_coor,coor_X,coor_Y)
coordenadas(coor1,100,100).
coordenadas(coor2,80,60).

% tipo(cod_tipo,nome).
tipo(0, sem_takeAway).
tipo(1, takeAway).

% regiao(cod_regiao, nome_regiao).
regiao(n,norte).
regiao(c,centro).
regiao(s,sul).

% localidade(nome_loc,cod_regiao).
localidade(braga, n).

% restaurante(nome_rest, nome_loc, cod_tipo, cod_coor).
restaurante(atum,braga,1,coor1).
restaurante(bacalhau,porto,0,coor2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que não permite a insercao de conhecimento repetido

+coordenadas(Cod_coor,Coor_X,Coor_Y) :: (solucoes( cod, (coordenadas(cod_coor,coor_X,coor_Y)), S),
										comprimento( S,N ), N==1
										).

%-coordenadas(cod_coor,coor_X,coor_Y) :: ().

+localidade(Loc,Regiao) :: (solucoes( Loc, (localidade(Loc,Regiao)), S),
									comprimento( S,N ), N==1
									).

%-localidade(nome_loc,cod_regiao) :: (
%									).


+restaurante(Nome,Loc,Tipo,Coor) :: (solucoes( Nome, (restaurante(Nome,_,_,_)), S),
									comprimento( S,N ), N==1
									).
%+restaurante(Nome,Loc,Tipo,Coor) :: ( coordenadas(Coor) ).
+restaurante(Nome,Loc,Tipo,Coor) :: ( localidade(Loc,_) ).


%-restaurante(N,NLoc,cTipo,cCoor) :: (
%									).

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

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
sqrt(N,S) :- loop(N, 0, 1, 1, S).

loop(N, Sqrt, Odd, Sum, Ans) :-
        Sum =< N,
        Sqrt1 is Sqrt+1,
        Odd1 is Odd+2,
        Sum1 is Sum+Odd,
        loop(N, Sqrt1, Odd1, Sum1, Ans).

loop(N, Sqrt, _, Sum, Sqrt) :- Sum > N.

distancia(X,Y,A,B,R) :- R is sqrt(((X-A)*(X-A))+((Y-B)*(Y-B))).
