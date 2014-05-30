% Distribuicao da Computacao - LINDA

% SICStus PROLOG: definicoes iniciais
:- op( 800,xfx,'::' ).
:- dynamic '-'/1.
:- dynamic e_um/2.
:- dynamic revestimento/2.
:- dynamic alimento/2.
:- dynamic cor/2.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Carregamento das bibliotecas

:-use_module( library( 'linda/client' ) ).
:-use_module(library('system')).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado e_um: SubClasse,Classe -> {V,F}

e_um(batman,ave).
e_um(batman,mamifero).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write('Sou o BATMAN'),nl,
    in(demo(batman,Questao)),
    write('demo(batman,Questao)'),nl,
    demo(batman,Questao),
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


%-------------------------------------------------------------------- REVESTIMENTO ----------------------------------------------------
%Extensao do predicado batman: batman, revestimento -> {V,F}

batman::revestimento(pelos).



% Conhecimento nao pode ser repetido
+(Ar::revestimento(C)) :: (findall(C, Ar::revestimento(C), S),
                    comprimento(S,N), N == 1
                    ).


%-- Conhecimento negativo
-revestimento(A) :- nao(revestimento(A)), nao(excecao(revestimento(A))).





%----------------------------------------------------------------- ALIMENTO --------------------------------------------------------------
%Extensao do predicado batman: batman, alimento -> {V,F}

batman::alimento(lasanha).
batman::alimento('arroz de cabidela').
batman::alimento('peixe grelhado no forno').



% Conhecimento nao pode ser repetido
+(Ar::alimento(C)) :: (findall(C, Ar::alimento(C), S),
                    comprimento(S,N), N == 1
                    ).


%-- Conhecimento negativo
-alimento(A) :- nao(alimento(A)), nao(excecao(alimento(A))).



%----------------------------------------------------------------- COR --------------------------------------------------------------
%Extensao do predicado batman: batman, Cor -> {V,F}

batman::cor(branco).
batman::cor(preto).
batman::cor(amarelo).


% Conhecimento nao pode ser repetido
+(Ar::cor(C)) :: (findall(C, Ar::cor(C), S),
                    comprimento(S,N), N == 1
                    ).


%-- Conhecimento negativo
-cor(A) :- nao(cor(A)), nao(excecao(cor(A))).



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