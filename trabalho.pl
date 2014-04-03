%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais
:- op( 900,xfy,'::' ).
:- dynamic '-'/1.
:- dynamic restaurante/1.
:- dynamic tipo/2.
:- dynamic coordenadas/3.
:- dynamic regiao/2.
:- dynamic zona/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado restaurante: Nome -> {V,F}

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de conhecimento inicial
restaurante('Tasquinha').
restaurante('Taberna').
restaurante('ZeroZero').

coordenadas('Tasquinha',1,1).
coordenadas('Taberna',2,2).
coordenadas('ZeroZero',3,3).

regiao('Tasquinha','norte').
regiao('Taberna','centro').
regiao('ZeroZero','sul').

zona('Tasquinha','braga').
zona('Taberna','coimbra').
zona('ZeroZero','lisboa').

tipo('Tasquinha',0).
tipo('Taberna',1).
tipo('ZeroZero', 0).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Restaurante

+restaurante( Nome ) :: (solucoes(Nome, (restaurante(Nome)), S),
						comprimento( S, N), N==1
						).

-restaurante( Nome ) :: (-coordenadas(Nome,XX,YY), -zona(Nome,Z),
						 -regiao(Nome,_), tipo(Nome,_)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Coordenadas

+coordenadas(Nome,XX,YY) :: (solucoes( Nome, (coordenadas(Nome,_,_)), S),
							comprimento( S,N ), N==1, XX>=0, YY>=0
							).
+coordenadas(Nome,XX,YY) :: (solucoes( (XX,YY), (coordenadas(_,XX,YY)), S),
							comprimento( S,N ), N==1, XX>=0, YY>=0
							).
+coordenadas(Nome,XX,YY) :: ( restaurante( Nome) ).

%--------------------------------- - - - - - - - - - - - - - - - - - -- 

% Tipo

+tipo(Nome,X) :: (solucoes( Nome, (tipo(Nome,_)), S),
							comprimento( S,N ), N==1, X=1;X=0 
							).
+tipo(Nome,_) :: ( restaurante(Nome) ).

%--------------------------------- - - - - - - - - - - - - - - - - - -- 

% regiao

+regiao(Nome,X) :: (solucoes( Nome, (regiao(Nome,_)), S),
							comprimento( S,N ), N==1, X='n';X='N';X='s';X='S';X='c';X='C'
							).
+regiao(Nome,_) :: ( restaurante(Nome) ).

%--------------------------------- - - - - - - - - - - - - - - - - - -- 

% zona

+zona(Nome,X) :: (solucoes( Nome, (zona(Nome,_)), S),
							comprimento( S,N ), N==1
							).
+zona(Nome,_) :: ( restaurante(Nome) ).

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
