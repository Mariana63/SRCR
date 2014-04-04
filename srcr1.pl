%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais
:- op( 900,xfy,'::' ).
:- dynamic '-'/1.
:- dynamic ligacao/2.
:- dynamic localizacao/2.
:- dynamic distanciaAux/3.
:- dynamic distancia/3.
:- dynamic procuraLocalizacao/2.
:- dynamic caminhosCusto/4.
:- dynamic custoMinimo/4.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

localizacao('braga', (2,1)).
localizacao('porto', (2,5)).
localizacao('lisboa', (1,6)).
localizacao('aveiro', (1,9)).
localizacao('coimbra', (1,5)).

ligacao(braga, porto,R) :- distancia(5,9,3,7,R).
ligacao(porto, coimbra,5).
ligacao(porto, aveiro,7) :- distancia(3,7,2,4,R).
ligacao(porto, leiria,612).
ligacao(aveiro, lisboa, 6).
ligacao(coimbra, lisboa,600).
ligacao(leiria, lisboa, 4).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Calcula Distancia entre 2 pontos
distancia(X,Y,A,B,R) :- R is sqrt(((X-A)*(X-A))+((Y-B)*(Y-B))).

%------------------------------------------------------------- FUNÇÕES ----------------------------------------------

procuraLocalizacao(X, R):- localizacao(X, R).




distanciaAux((X1,Y1),(X2,Y2),R) :- R is sqrt(((X1-X2)*(X1-X2))+((Y1-Y2)*(Y1-Y2))).
distancia(O, D, R) :- hacaminho(O, D), procuraLocalizacao(O, RO), procuraLocalizacao(D, RD), distanciaAux(RO, RD, R).


%retorna sim ou não conforme houver caminha entre os pontos A e B.
hacaminho(A, B) :- ligacao(A, B), !.
hacaminho(A, B) :- ligacao(A, X), hacaminho(X, B).



%------------------------------------------------------------- FUNÇÕES ----------------------------------------------

ha_caminho(A, B) :- ligacao(A, B, _), !.
ha_caminho(A, B) :- ligacao(A, X, _),
ha_caminho(X, B).

travessia(A, B, Visitados, [B|Visitados]) :- ligacao(A, B, _).
travessia(A, B, Visitados, Cam) :- ligacao(A, C, _),
									C \== B,
									\+ member(C, Visitados),
									travessia(C, B, [C|Visitados], Cam).


caminho(A, B, Cam) :- travessia(A, B, [A], Cam).


caminhos(A, B, Lc) :- setof(Cam, caminho(A, B, Cam), Lc), !.
caminhos(_, _, []).

caminhoCusto(A, B, Cam, Custo) :- travessiaCusto(A, B, [A], Cam, Custo).


travessiaCusto(A, B, Visitados,[B|Visitados], Custo1) :- ligacao(A, B, Custo1).
travessiaCusto(A, B, Visitados, Cam, Custo) :- ligacao(A, C, Custo2),
     											C \== B,
     											\+ member(C, Visitados),
     											travessiaCusto(C, B, [C|Visitados], Cam, CustoResto),
     											Custo is Custo2 + CustoResto.

caminhosCusto(A, B, Lc) :- setof(Cam:Custo, caminhoCusto(A, B, Cam,Custo), Lc), !.
caminhosCusto(_, _, []).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Função que devolve o custoMinimo entre duas cidades
menor([],K,X,X,K).
menor([C:X|XS],K,M,R,CA) :- X =< M, menor(XS,C,X,R,CA).
menor([C:X|XS],K,M,R,CA) :- M <  X, menor(XS,K,M,R,CA).

custoMinimo(A,B,R,CA) :- caminhosCusto(A,B,[HC:HP|T]),
						 menor([HC:HP|T],HC,HP,R,CA).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

nodos(Ln) :- setof(N,(X^C^ligacao(X, N, C);
             Y^C^ligacao(N, Y, C)), Ln), !.
nodos([]).
