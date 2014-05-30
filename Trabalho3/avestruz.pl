% Distribuicao da Computacao - LINDA

% SICStus PROLOG: definicoes iniciais
:- op(900,xfx,'::' ).
:- dynamic '-'/1.
:- dynamic e_um/2.
:- dynamic locomocao/2.
:- dynamic reproducao/2.
:- dynamic cor/2.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Carregamento das bibliotecas

:-use_module( library( 'linda/client' ) ).
:-use_module(library('system')).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado e_um: SubClasse,Classe -> {V,F}

e_um(avestruz,ave).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write('Sou uma AVESTRUZ'),nl,
    in(demo(avestruz,Questao)),
    write('demo(avestruz,Questao)'),nl,
    demo(avestruz,Questao),
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


%-------------------------------------------------------------------- LOCOMOCAO ----------------------------------------------------
%Extensao do predicado avestruz: avestruz, Locomocao -> {V,F}

avestruz::locomocao(andamento).



% Conhecimento nao pode ser repetido
+(Ar::locomocao(C)) :: (findall(C, Ar::locomocao(C), S),
                    comprimento(S,N), N == 1
                    ).


%-- Conhecimento negativo
-locomocao(A) :- nao(locomocao(A)), nao(excecao(locomocao(A))).





%----------------------------------------------------------------- REPRODUCAO --------------------------------------------------------------
%Extensao do predicado avestruz: avestruz, Reproducao -> {V,F}

avestruz::reproducao(ovipara).



% Conhecimento nao pode ser repetido
+(Ar::revestimento(C)) :: (findall(C, Ar::revestimento(C), S),
                    comprimento(S,N), N == 1
                    ).


%-- Conhecimento negativo
-revestimento(A) :- nao(revestimento(A)), nao(excecao(revestimento(A))).



%----------------------------------------------------------------- COR --------------------------------------------------------------
%Extensao do predicado avestruz: avestruz, Cor -> {V,F}

avestruz::cor(branco).
avestruz::cor(preto).
avestruz::cor(castanho).


% Conhecimento nao pode ser repetido
+(Ar::classe(C)) :: (findall(C, Ar::classe(C), S),
                    comprimento(S,N), N == 1
                    ).


%-- Conhecimento negativo
-classe(A) :- nao(classe(A)), nao(excecao(classe(A))).



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