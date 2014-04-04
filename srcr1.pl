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
:- dynamic distancia/5.
:- dynamic caminhosCusto/4.
:- dynamic custoMinimo/4.



ligacao(braga, porto,R) :- distancia(5,9,3,7,R).
ligacao(porto, coimbra,5).
ligacao(porto, aveiro,7) :- distancia(3,7,2,4,R).
ligacao(porto, leiria,612).
ligacao(aveiro, lisboa, 6).
ligacao(coimbra, lisboa,600).
ligacao(leiria, lisboa, 4).


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
% Funão que devolve o custoMinimo entre duas cidades
menor([],K,X,X,K).
menor([C:X|XS],K,M,R,CA) :- X =< M, menor(XS,C,X,R,CA).
menor([C:X|XS],K,M,R,CA) :- M <  X, menor(XS,K,M,R,CA).

custoMinimo(A,B,R,CA) :- caminhosCusto(A,B,[HC:HP|T]),
						 menor([HC:HP|T],HC,HP,R,CA).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

nodos(Ln) :- setof(N,(X^C^ligacao(X, N, C);
             Y^C^ligacao(N, Y, C)), Ln), !.
nodos([]).

distancia(X,Y,A,B,R) :- R is sqrt(((X-A)*(X-A))+((Y-B)*(Y-B))).
