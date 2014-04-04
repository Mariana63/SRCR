%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais
:- op( 900,xfy,'::' ).
:- dynamic '-'/1.
:- dynamic ligacao/3.
:- dynamic localizacao/2.
:- dynamic distanciaAux/3.
:- dynamic distancia/3.
:- dynamic procuraLocalizacao/2.
:- dynamic caminhosCusto/4.
:- dynamic caminhoMinimo/4.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

localizacao('braga', (2,1)).
localizacao('porto', (2,5)).
localizacao('lisboa', (1,6)).
localizacao('barcelos', (1,9)).
localizacao('felgueiras', (3,6)).
localizacao('santarem', (1,5)).
localizacao('portimao', (1,6)).
localizacao('leiria', (1,3)).



ligacao(braga, porto, R) :- distancia((5,9),(3,7),R).
ligacao(porto, coimbra, 10).
ligacao(porto, aveiro, R) :- distancia((3,7),(2,4),R).
ligacao(aveiro, lisboa, 7).
ligacao(coimbra, lisboa, 100).

%------------------------------------------------------------- FUNÇÕES ----------------------------------------------

procuraLocalizacao(X, R):- localizacao(X, R).


distanciaAux((X1,Y1),(X2,Y2),R) :- R is sqrt(((X1-X2)*(X1-X2))+((Y1-Y2)*(Y1-Y2))).



distancia(O, D, R) :- procuraLocalizacao(O, RO), procuraLocalizacao(D, RD), distanciaAux(RO, RD, R).






%------------------------------------------------------------- FUNÇÕES ----------------------------------------------


%retorna sim ou não conforme houver caminha entre os pontos A e B.
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

caminhosCusto(A, B, Lc) :- setof(Cam/Custo, caminhoCusto(A, B, Cam,Custo), Lc), !.
caminhosCusto(_, _, []).

menor([],COMP,R, CA).
menor([C/X|XS], COMP, R, CA) :- X<COMP, R is X, CA=C ,menor(XS,X,R,CA).
menor([C/X|XS], COMP, R, CA) :- X>=COMP, R is COMP, menor(XS,COMP,R,CA).

caminhoMinimo(A,B,R,CA) :- caminhosCusto(A,B,LC),
						 menor(LC,99999,R,CA).


nodos(Ln) :- setof(N,(X^C^ligacao(X, N, C);
             Y^C^ligacao(N, Y, C)), Ln), !.
nodos([]).
