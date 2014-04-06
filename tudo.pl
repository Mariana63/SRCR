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

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% localizacoes das cidades
localizacao('Viana_Castelo', (110,620)).
localizacao('Braga', (143,578)).
localizacao('Vila_Real', (200,567)).
localizacao('Braganca', (301,612)).
localizacao('Porto', (123,543)).
localizacao('Aveiro', (114,498)).
localizacao('Viseu', (196,500)).
localizacao('Guarda', (286,476)).
localizacao('Coimbra', (158,453)).
localizacao('Castelo_Branco', (275,410)).
localizacao('Leiria', (104,396)).
localizacao('Santarem', (144,307)).
localizacao('Lisboa', (100,260)).
localizacao('Portalegre', (259,325)).
localizacao('Setubal', (109,241)).
localizacao('Evora', (215,245)).
localizacao('Beja', (188,147)).
localizacao('Faro', (200,50)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ligações existentes entre cada nodo da empresa
ligacao('Viana_Castelo','Braga',R) :- distancia('Viana_Castelo','Braga',R).
ligacao('Braga','Viana_Castelo',R) :- distancia('Braga','Viana_Castelo',R).
ligacao('Braga','Porto',R) :- distancia('Braga','Porto',R).
ligacao('Braga','Vila_Real',R) :- distancia('Braga','Vila_Real',R).
ligacao('Vila_Real','Braga',R) :- distancia('Vila_Real','Braga',R).
ligacao('Vila_Real','Braganca',R) :- distancia('Vila_Real','Braganca',R).
ligacao('Vila_Real','Guarda',R) :- distancia('Vila_Real','Guarda',R).
ligacao('Braganca','Vila_Real',R) :- distancia('Braganca','Vila_Real',R).
ligacao('Braganca','Guarda',R) :- distancia('Braganca','Guarda',R).
ligacao('Porto','Braga',R) :- distancia('Porto','Braga',R).
ligacao('Porto','Aveiro',R) :- distancia('Porto','Aveiro',R).
%ligacao('Porto','Coimbra',R) :- distancia('Porto','Coimbra',R).
ligacao('Porto','Viseu',R) :- distancia('Porto','Viseu',R).
ligacao('Aveiro','Porto',R) :- distancia('Aveiro','Porto',R).
ligacao('Aveiro','Coimbra',R) :- distancia('Aveiro','Coimbra',R).
ligacao('Aveiro','Leiria',R) :- distancia('Aveiro','Leiria',R).
%ligacao('Coimbra','Porto',R) :- distancia('Coimbra','Porto',R).
ligacao('Coimbra','Aveiro',R) :- distancia('Coimbra','Aveiro',R).
ligacao('Coimbra','Castelo_Branco',R) :- distancia('Coimbra','Castelo_Branco',R).
ligacao('Viseu','Porto',R) :- distancia('Viseu','Porto',R).
ligacao('Viseu','Castelo_Branco',R) :- distancia('Viseu','Castelo_Branco',R).
%ligacao('Viseu','Guarda',R) :- distancia('Viseu','Guarda',R).
ligacao('Guarda','Vila_Real',R) :- distancia('Guarda','Vila_Real',R).
%ligacao('Guarda','Viseu',R) :- distancia('Guarda','Viseu',R).
ligacao('Guarda','Castelo_Branco',R) :- distancia('Guarda','Castelo_Branco',R).
ligacao('Guarda','Braganca',R) :- distancia('Guarda','Braganca',R).
ligacao('Castelo_Branco','Guarda',R) :- distancia('Castelo_Branco','Guarda',R).
ligacao('Castelo_Branco','Viseu',R) :- distancia('Castelo_Branco','Viseu',R).
ligacao('Castelo_Branco','Coimbra',R) :- distancia('Castelo_Branco','Coimbra',R).
ligacao('Castelo_Branco','Santarem',R) :- distancia('Castelo_Branco','Santarem',R).
ligacao('Castelo_Branco','Portalegre',R) :- distancia('Castelo_Branco','Portalegre',R).
ligacao('Leiria','Aveiro',R) :- distancia('Leiria','Aveiro',R).
ligacao('Leiria','Lisboa',R) :- distancia('Leiria','Lisboa',R).
ligacao('Leiria','Santarem',R) :- distancia('Leiria','Santarem',R).
ligacao('Lisboa','Leiria',R) :- distancia('Lisboa','Leiria',R).
ligacao('Lisboa','Santarem',R) :- distancia('Lisboa','Santarem',R).
ligacao('Lisboa','Setubal',R) :- distancia('Lisboa','Setubal',R).
ligacao('Santarem','Leiria',R) :- distancia('Santarem','Leiria',R).
ligacao('Santarem','Lisboa',R) :- distancia('Santarem','Lisboa',R).
%ligacao('Santarem','Setubal',R) :- distancia('Santarem','Setubal',R).
ligacao('Santarem','Castelo_Branco',R) :- distancia('Santarem','Castelo_Branco',R).
ligacao('Santarem','Evora',R) :- distancia('Santarem','Evora',R).
ligacao('Portalegre','Castelo_Branco',R) :- distancia('Portalegre','Castelo_Branco',R).
ligacao('Portalegre','Evora',R) :- distancia('Portalegre','Evora',R).
ligacao('Portalegre','Beja',R) :- distancia('Portalegre','Beja',R).
ligacao('Setubal','Lisboa',R) :- distancia('Setubal','Lisboa',R).
%ligacao('Setubal','Santarem',R) :- distancia('Setubal','Santarem',R).
ligacao('Setubal','Beja',R) :- distancia('Setubal','Beja',R).
ligacao('Setubal','Faro',R) :- distancia('Setubal','Faro',R).
ligacao('Evora','Portalegre',R) :- distancia('Evora','Portalegre',R).
ligacao('Evora','Santarem',R) :- distancia('Evora','Santarem',R).
ligacao('Evora','Beja',R) :- distancia('Evora','Beja',R).
ligacao('Beja','Portalegre',R) :- distancia('Beja','Portalegre',R).
ligacao('Beja','Evora',R) :- distancia('Beja','Evora',R).
ligacao('Beja','Portalegre',R) :- distancia('Beja','Portalegre',R).
ligacao('Beja','Setubal',R) :- distancia('Beja','Setubal',R).
ligacao('Beja','Faro',R) :- distancia('Beja','Faro',R).
ligacao('Faro','Beja',R) :- distancia('Faro','Beja',R).
ligacao('Faro','Setubal',R) :- distancia('Faro','Setubal',R).

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
