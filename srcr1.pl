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
:- dynamic caminhoMinimo/4.



ligacao(braga, porto,R) :- distancia(5,9,3,7,R).
ligacao(porto, coimbra, 10).
ligacao(porto, aveiro,R) :- distancia(3,7,2,4,R).
ligacao(aveiro, lisboa, 7).
ligacao(coimbra, lisboa,100).


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

distancia(X,Y,A,B,R) :- R is sqrt(((X-A)*(X-A))+((Y-B)*(Y-B))).
