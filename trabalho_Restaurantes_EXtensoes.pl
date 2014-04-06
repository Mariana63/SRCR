%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Restaurante

+restaurante( Nome ) :: (solucoes(Nome, (restaurante(Nome)), S),
						comprimento( S, N), N==1
						).

-restaurante( Nome ) :: (-coordenadas(Nome,XX,YY), -zona(Nome,Z),
						 -regiao(Nome,_), -tipo(Nome,_)).

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
sqrt(N,S) :- loop(N, 0, 1, 1, S).

loop(N, Sqrt, Odd, Sum, Ans) :-
        Sum =< N,
        Sqrt1 is Sqrt+1,
        Odd1 is Odd+2,
        Sum1 is Sum+Odd,
        loop(N, Sqrt1, Odd1, Sum1, Ans).

loop(N, Sqrt, _, Sum, Sqrt) :- Sum > N.

distancia(X,Y,A,B,R) :- R is sqrt(((X-A)*(X-A))+((Y-B)*(Y-B))).

verifica(NO,ND,R) :- coordenadas(NO,OX,OY),
					 coordenadas(ND,DX,DY),
					 distancia(OX,OY,DX,DY,R).

listas([],0).
listas([X],0).
listas([X,Y | XYS],R) :- listas([Y|XYS],RR),
						 verifica(X,Y,R2),
						 R is R2+RR.

pertence(X,[X|L]).
pertence(X,[Y|L]) :- X\==Y, pertence(X,L).

const(X,Y,R) :- R is [X|Y]. 

caminhoDireto(A, B) :- ligacao(A,R),
					   pertence(B,R).

procuraCaminho(O,D, C) :- ligacao(O,R),

						  procuraCaminho([R],D,C)
