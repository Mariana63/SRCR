%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SISTEMAS DE REPRESENTACAO DE CONHECIMENTO E RACIOCINIO - LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

% Distribuicao da Computacao - LINDA

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 800,xfx,'::' ).
:- dynamic locomocao/2.
:- dynamic habitat/2.
:- dynamic alimentacao/2.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Carregamento das bibliotecas

:- use_module( library( 'linda/client' ) ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Teoria representada na forma Agente :: Conhecimento



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado e_um: Agente,Classe -> {V,F}



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write( 'BATMAN' ),nl,
    in(demo( batman,Questao ) ),
    write( 'demo( batman,Questao )' ),nl,
    demo(batman,Questao ),
    demo.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Agente,Questao -> {V,F}

demo(Agente,Questao ) :-
    Agente::Questao,
    write(( 1,Agente::Questao ) ),nl,
    out(prova( Agente,Questao ) ).

demo(Agente,Questao ) :-
    e_um(Agente,Classe ),
    write(( 2,e_um( Agente,Classe ) ) ),nl,
    out(demo( Classe,Questao ) ).

demo(Agente,Questao ) :-
    write(( 3,nao ) ),nl,
    out(prova( Agente,nao ) ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensao do predicado locomocao: Batman,Locomocao -> {V,F}

ave :: locomocao( voo ).


%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::locomocao(A)) :: (findall(A, Ar::locomocao( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-locomocao(A) :- nao(locomocao(A)), nao(excecao(locomocao(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensao do predicado habitat: Batman,Habitat -> {V,F}

ave :: habitat( caverna ).


%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::habitat(A)) :: (findall(A, Ar::habitat( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-habitat(A) :- nao(habitat(A)), nao(excecao(habitat(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensao do predicado alimentacao: Batman,alimentacao -> {V,F}

ave :: alimentacao( insetos ).
ave :: alimentacao( fruta ).

%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::alimentacao(A)) :: (findall(A, Ar::alimentacao( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-alimentacao(A) :- nao(alimentacao(A)), nao(excecao(alimentacao(A))).
























ligar( QN ) :-
    linda_client( QN ).

qn( L ) :-
    bagof_rd_noblock( X,X,L ).
