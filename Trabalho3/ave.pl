% Distribuicao da Computacao - LINDA


% SICStus PROLOG: definicoes iniciais
:- op( 800,xfx,'::' ).
:- dynamic '-'/1.
:- dynamic alimentacao/2.
:- dynamic habitat/2.
:- dynamic locomocao/2.
:- dynamic cobertura/2.
:- dynamic reproducao/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Carregamento das bibliotecas

:-use_module(library('linda/client')).
:-use_module(library('system')).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado e_um: Agente,Classe -> {V,F}

e_um(ave,animal).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write('Sou uma AVE'),nl,
    in(demo(ave,Questao)),
    write('demo(ave,Questao)'),nl,
    demo(ave,Questao),
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


%------------------------------------------------------------------- ALIMENTACAO ----------------------------------------------------
%Extensao do predicado alimentacao: Ave,Alimento -> {V,F}

ave::alimentacao(carnivoro).


%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::alimentacao(A)) :: (findall(A, Ar::alimentacao( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-alimentacao(A) :- nao(alimentacao(A)), nao(excecao(alimentacao(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensao do predicado habitat: Ave,Habitat -> {V,F}

ave :: habitat( floresta ).
ave :: habitat( deserto ).


%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::habitat(A)) :: (findall(A, Ar::habitat( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-habitat(A) :- nao(habitat(A)), nao(excecao(habitat(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensao do predicado locomocao: Ave,Locomocao -> {V,F}

ave :: locomocao( voo ).


%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::locomocao(A)) :: (findall(A, Ar::locomocao( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-locomocao(A) :- nao(locomocao(A)), nao(excecao(locomocao(A))).



%--------------------------------------------------------------------- COBERTURA ------------------------------------------------
%Extensao do predicado cobertura: Ave,Cobertura -> {V,F}

ave :: cobertura( penas ).


%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::cobertura(A)) :: (findall(A, Ar::cobertura( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-cobertura(A) :- nao(cobertura(A)), nao(excecao(cobertura(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensao do predicado reproducao: Ave,Reproducao -> {V,F}

ave :: reproducao( ovipara ).


%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::reproducao(A)) :: (findall(A, Ar::reproducao( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-reproducao(A) :- nao(reproducao(A)), nao(excecao(reproducao(A))).






















ligar( QN ) :-
    linda_client( QN ).

qn( L ) :-
    bagof_rd_noblock( X,X,L ).
