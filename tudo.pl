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
:- dynamic custoMinimo/4.
:- dynamic caminhoMinimo/4.
:- dynamic caminhoSeq/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% 0- normal, 1- express, 2- ambas ????
tipoEntrega('Viana_Castelo', 0).
tipoEntrega('Braga', 2).
tipoEntrega('Vila_Real', 1).
tipoEntrega('Braganca', 2).
tipoEntrega('Porto', 1).
tipoEntrega('Aveiro', 2).
tipoEntrega('Viseu', 2).
tipoEntrega('Guarda', 1).
tipoEntrega('Coimbra', 1).
tipoEntrega('Castelo_Branco', 0).
tipoEntrega('Leiria', 0).
tipoEntrega('Santarem', 1).
tipoEntrega('Portalegre',0).
tipoEntrega('Lisboa', 2).
tipoEntrega('Setubal', 1).
tipoEntrega('Evora', 1).
tipoEntrega('Beja', 2).
tipoEntrega('Faro', 0).


localizacao('Viana_Castelo', (8,33)).
localizacao('Braga', (9,31)).
localizacao('Vila_Real', (11,30)).
localizacao('Braganca', (15,33)).
localizacao('Porto', (6,28)).
localizacao('Aveiro', (6,25)).
localizacao('Viseu', (10,25)).
localizacao('Guarda', (14,24)).
localizacao('Coimbra', (8,22)).
localizacao('Castelo_Branco', (12,19)).
localizacao('Leiria', (6,19)).
localizacao('Santarem', (7,16)).
localizacao('Lisboa', (5,12)).
localizacao('Portalegre', (12,15)).
localizacao('Setubal', (7,11)).
localizacao('Evora', (10,12)).
localizacao('Beja', (10,8)).
localizacao('Faro', (10,2)).



zona('Viana_Castelo', 'Norte').
zona('Braga', 'Norte').
zona('Vila_Real', 'Norte').
zona('Braganca','Norte').
zona('Porto', 'Norte').
zona('Aveiro', 'Centro').
zona('Viseu', 'Centro').
zona('Guarda', 'Centro').
zona('Coimbra', 'Centro').
zona('Castelo_Branco', 'Centro').
zona('Leiria', 'Centro').
zona('Lisboa', 'Centro').
zona('Santarem', 'Centro').
zona('Portalegre', 'Sul').
zona('Setubal', 'Sul').
zona('Evora', 'Sul').
zona('Beja', 'Sul').
zona('Faro', 'Sul').


sigla('Aveiro', 'A').
sigla('Beja', 'BJ').
sigla('Braga', 'BRG').
sigla('Braganca', 'BG').
sigla('Castelo_Branco', 'CB').
sigla('Coimbra', 'C').
sigla('Evora', 'E').
sigla('Faro', 'F').
sigla('Guarda', 'G').
sigla('Leiria', 'LR').
sigla('Lisboa', 'LX').
sigla('Portalegre', 'PL').
sigla('Porto', 'PT').
sigla('Santarem', 'STR').
sigla('Setubal', 'ST').
sigla('Viana_Castelo','VC').
sigla('Vila_Real', 'VR').
sigla('Viseu', 'V').



ligacao('Braga','Porto',R) :- distancia('Braga','Porto',R).
ligacao('Porto','Coimbra',R) :- distancia('Porto','Coimbra',R).
ligacao('Porto','Aveiro',R) :- distancia('Porto','Aveiro',R).
ligacao('Porto','Leiria',R) :- distancia('Porto','Leiria',R).
ligacao('Aveiro','Lisboa',R) :- distancia('Aveiro','Lisboa',R).
ligacao('Coimbra','Lisboa',R) :- distancia('Coimbra','Lisboa',R).
ligacao('Leiria','Lisboa',R) :- distancia('Leiria','Lisboa',R).

%------------------------------------------------------------- FUNÇÕES ----------------------------------------------

procuraTipo(X,R) :- tipoEntrega(X,R).


procuraZona(X,R) :- zona(X,R).


procuraLocalizacao(X, R):- localizacao(X, R).


distanciaAux((X1,Y1),(X2,Y2),R) :- R is sqrt(((X1-X2)*(X1-X2))+((Y1-Y2)*(Y1-Y2))).
distancia(O, D, R) :- procuraLocalizacao(O, RO), procuraLocalizacao(D, RD), distanciaAux(RO, RD, R).


%retorna sim ou não conforme houver caminho entre os pontos A e B.
hacaminho(A, B) :- ligacao(A, B,_), !.
hacaminho(A, B) :- ligacao(A, X,_), hacaminho(X, B).


%------------------------------------------------------------- FUNÇÕES ----------------------------------------------

ha_caminho(A, B) :- ligacao(A, B, _), !.
ha_caminho(A, B) :- ligacao(A, X, _), ha_caminho(X, B).

travessia(A, B, Visitados, [B|Visitados]) :- ligacao(A, B, _).
travessia(A, B, Visitados, Cam) :- ligacao(A, C, _),
									C \== B,
									\+ member(C, Visitados),
									travessia(C, B, [C|Visitados], Cam).

caminho(A, B, Cam) :- travessia(A, B, [A], Ca), inverter(Ca,Cam).

caminhos(A, B, Lc) :- setof(Cam, caminho(A, B, Cam), Lc), !.
caminhos(_, _, []).

travessiaCusto(A, B, Visitados,[B|Visitados], Custo1) :- ligacao(A, B, Custo1).
travessiaCusto(A, B, Visitados, Cam, Custo) :- ligacao(A, C, Custo2),
     											C \== B,
     											\+ member(C, Visitados),
     											travessiaCusto(C, B, [C|Visitados], Cam, CustoResto),
     											Custo is Custo2 + CustoResto.

caminhoCusto(A, B, Cam, Custo) :- travessiaCusto(A, B, [A], Ca, Custo), inverter(Ca,Cam).

caminhosCusto(A, B, Lc) :- setof(Cam:Custo, caminhoCusto(A, B, Cam,Custo), Lc), !.
caminhosCusto(_, _, []).

nodos(Ln) :- setof(N,(X^C^ligacao(X, N, C);
             Y^C^ligacao(N, Y, C)), Ln), !.
nodos([]).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Função Conjuntos

conjuntoCusto(XS, Cu, Path) :- conjunto(XS,Pa),
							   removePathIgual(Pa,Pa,Path),
							   custoAux(Path,0,Cu).

removePathIgual([],P,P).
removePathIgual([X],P,P).
removePathIgual([X,Y|XS],PP,P) :- X=Y, apagar(X,PP,PPP), removePathIgual(PPP,PPP,P).
removePathIgual([X,Y|XYS],PP,P) :- X\=Y, removePathIgual([Y|XYS],PP,P).

custoAux([],CU,CU).
custoAux([X],CU,CU).
custoAux([X,Y |XS],XX,CU) :- ligacao(X,Y,R1),
							 soma(R1,XX,R2),
							 custoAux([Y|XS],R2,CU).

conjunto([], Path).
conjunto(XS, Path) :- conjuntoAux(XS,[],Path).

conjuntoAux([],F,F).
conjuntoAux([X],F,F).
conjuntoAux([VX,VY|VS],X,F) :- caminho(VX,VY,FFF), 
							   concatena(X,FFF,FF),
							   conjuntoAux([VY|VS],FF,F).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Funções - distância miníma de uma dada sequencia

caminhoMinimo(A,B,R,CA) :- caminhosCusto(A,B,LC),
						 menor(LC,99999,R,CA).
						 
caminhoSeq([],0).
caminhoSeq([X],0). 
caminhoSeq([X,XS|XY],R) :- caminhoMinimo(X,XS,R2,LL),
						    caminhoSeq([XS|XY],RES),
						    R is R2+RES.


%% 

sequenciaMinima(XS,R) :- seqAux(XS,0,R).

seqAux([],R,R).
seqAux([X],R,R).
seqAux([X,Y|XYS],R,RRR) :- custoMinimo(X,Y,RR,_), soma(RR,R,R2), seqAux([Y|XYS],R2,RRR).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Função que devolve o custoMinimo entre duas cidades

menor([],K,X,X,K).
menor([C:X|XS],K,M,R,CA) :- X =< M, menor(XS,C,X,R,CA).
menor([C:X|XS],K,M,R,CA) :- M <  X, menor(XS,K,M,R,CA).

custoMinimo(A,B,R,CA) :- caminhosCusto(A,B,[HC:HP|T]),
						 menor([HC:HP|T],HC,HP,R,CA).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a evolucao do conhecimento

evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

insercao( Termo ) :- assert( Termo ).
insercao( Termo ) :- retract( Termo ),!,fail.

teste( [] ).
teste( [A|B] ) :- A, teste( B ).

solucoes( X,Y,Z ) :- findall( X,Y,Z ).

comprimento( S,N ) :- length( S,N ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a remocao do conhecimento

remocao( Termo ) :-
 	solucoes( Invariante,-Termo::Invariante,Lista ),
 	teste( Lista ),
    remover( Termo ).

remover( Termo ) :- retract( Termo ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Funções úteis
concatena([],L2,L2).
concatena([X|R], L2, [X|L]) :- concatena(R,L2,L).

inverter([],[]).
inverter([X|XS],L) :- inverter(XS,V), concatena(V,[X],L).

soma(X,Y,Z) :- Z is X+Y.

apagar(N,[N|XS], XS).
apagar(N,[X|XS],[X|L]) :- N\==X, apagar(N,XS,L).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}
nao(X) :- X,!,fail.
nao(X).
