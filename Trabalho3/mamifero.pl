% Distribuicao da Computacao - LINDA

% SICStus PROLOG: definicoes iniciais
:- op( 800,xfx,'::' ).
:- dynamic '-'/1.
:- dynamic e_um/2.
:- dynamic alimentacao/2.
:- dynamic cobertura/2.
:- dynamic reproducao/2.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Carregamento das bibliotecas

:-use_module( library( 'linda/client' ) ).
:-use_module(library('system')).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado e_um: Agente,Classe -> {V,F}

e_um(mamifero,animal).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write('Sou um MAMIFERO'),nl,
    in(demo(mamifero,Questao)),
    write('demo(mamifero,Questao)'),nl,
    demo(mamifero,Questao),
    demo.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Agente,Questao -> {V,F}

demo(Agente,Questao):-
    Agente::Questao,
    write((1,Agente::Questao)),nl,
    out(prova(Agente,Questao)).

demo(Agente,Questao):-
    e_um(Agente,Classe),
    write((2,e_um(Agente,Classe))),nl,
    out(demo(Classe,Questao)).

demo(Agente,Questao) :-
    write((3,nao)),nl,
    out(prova(Agente,nao)).

%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%-------------------------------------------------------------------------------- BASE DE CONHECIMENTO ---------------------------------------------------------------------
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------


%-------------------------------------------------------------------- MOVIMENTO ----------------------------------------------------
%Extensao do predicado movimento: Mamifero,Movimento -> {V,F}

mamifero::movimento(anda).



% Conhecimento nao pode ser repetido
+(Ar::movimento(C)) :: (findall(C, Ar::movimento(C), S),
                    comprimento(S,N), N == 1
                    ).


%-- Conhecimento negativo
-movimento(A) :- nao(movimento(A)), nao(excecao(movimento(A))).





%----------------------------------------------------------------- COBERTURA --------------------------------------------------------------
%Extensao do predicado cobertura: Mamifero,Cobertura -> {V,F}

mamifero::cobertura(pelos).



% Conhecimento nao pode ser repetido
+(Ar::cobertura(C)) :: (findall(C, Ar::cobertura(C), S),
                    comprimento(S,N), N == 1
                    ).


%-- Conhecimento negativo
-cobertura(A) :- nao(cobertura(A)), nao(excecao(cobertura(A))).



%----------------------------------------------------------------- REPRODUCAO --------------------------------------------------------------
%Extensao do predicado reproducao: Mamifero,Reproducao -> {V,F}

mamifero::reproducao(placentaria).
mamifero::reproducao(marsupial).


% Conhecimento nao pode ser repetido
+(Ar::reproducao(C)) :: (findall(C, Ar::reproducao(C), S),
                    comprimento(S,N), N == 1
                    ).


%-- Conhecimento negativo
-reproducao(A) :- nao(reproducao(A)), nao(excecao(reproducao(A))).



%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------- FUNÇÕES GERAIS -------------------------------------------------------------------
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------


% Extensão do predicado que permite a evolução (inserção) de conhecimento: Termo -> {v, F}
evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

solucoes(X,Y,Z):- findall(X, Y, Z).

insercao(Termo):- assert(Termo).
insercao(Termo):- retract(Termo), !, fail.

teste([]).
teste([R|LR]):- R, teste(LR).

%----------------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensao do meta-predicado nao: Questao -> {V,F}
nao(Questao):- Questao, !, fail.
nao(Questao).

%----------------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensão do predicado que permite a remoção de conhecimento: Termo -> {v, F}
remocao(Termo) :-
    solucoes(Invariante,-Termo::Invariante,Lista),
    teste(Lista),
    remover(Termo).

remover(Termo):- retract(Termo).

%----------------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensão do predicado comprimento: L, R -> {V, F}
comprimento([], 0) .
comprimento([H|T], R) :-
    comprimento(T, X),
    R is 1+X .

%----------------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -

ligar(QN):-linda_client(QN).

qn(L):-bagof_rd_noblock(X,X,L).