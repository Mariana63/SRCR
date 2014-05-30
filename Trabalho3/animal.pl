% Distribuicao da Computacao - LINDA

% SICStus PROLOG: definicoes iniciais
:- op( 800,xfx,'::' ).
:- dynamic '-'/1.
:- dynamic classe/2.
:- dynamic regime/2.
:- dynamic grupo/2.
:- dynamic reproducao/2.
:- dynamic e_um/2.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Carregamento das bibliotecas

:-use_module( library( 'linda/client' ) ).
:-use_module(library('system')).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write('Sou um ANIMAL'),nl,
    in(demo(animal,Questao)),
    write('demo(animal,Questao)'),nl,
    demo(animal,Questao),
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


%---------------------------------------------------------------------------------------- CLASSE --------------------------------------------------------------------------
%Extensao do predicado animal: Animal,Classe-> {V,F}

animal::classe(mamifero).
animal::classe(reptil).
animal::classe(paixe).
animal::classe(ave).
animal::classe(anfibio).
animal::classe(insecto).



% Conhecimento nao pode ser repetido
+(Ar::classe(C)) :: (findall(C, Ar::classe(C), S),
                    comprimento(S,N), N == 1
                    ).


%-- Conhecimento negativo
-classe(A) :- nao(classe(A)), nao(excecao(classe(A))).


%------------------------------------------------------------------------------------------ REGIME_ALIMENTAR ----------------------------------------------------------------
%Extensao do predicado animal: Animal,RegimeAlimentar -> {V,F}

animal::regime(herbivoro).
animal::regime(carnivoro).
animal::regime(omnivoro).



% Conhecimento nao pode ser repetido
+(Ar::regime(A)) :: (findall(A, Ar::regime( A ), S),
                        comprimento( S,N ), N == 1
                        ).


% Conhecimento negativo
-regime(A) :- nao(regime(A)), nao(excecao(regime(A))).


%------------------------------------------------------------------------------------------------ GRUPO --------------------------------------------------
%Extensao do predicado animal: Animal,Grupo -> {V,F}

animal::grupo(vertebrados).
animal::grupo(invertebrados).



% Conhecimento nao pode ser repetido
+(Ar::grupo(A)) :: (findall(A, Ar::grupo( A ), S),
                    comprimento( S,N ), N == 1
                    ).


% Conhecimento negativo
-grupo(A) :- nao(grupo(A)), nao(excecao(grupo(A))).


%------------------------------------------------------------------------------------------------ REPRODUCAO --------------------------------------------------
%Extensao do predicado animal: Animal,Reproducao -> {V,F}

animal::reproducao(oviparo).
animal::reproducao(viviparo).
animal::reproducao(ovovivipiparo).



% Conhecimento nao pode ser repetido
+(Ar::reproducao(A)) :: (findall(A, Ar::reproducao( A ), S),
                    comprimento( S,N ), N == 1
                    ).


% Conhecimento negativo
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

%QN = 'pc-name':'9999'
ligar(QN):-linda_client(QN).

% X, p(X), S
qn(L):-bagof_rd_noblock(X,X,L).



