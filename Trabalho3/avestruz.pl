%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SISTEMAS DE REPRESENTACAO DE CONHECIMENTO E RACIOCINIO - LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

% Distribuicao da Computacao - LINDA

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 800,xfx,'::' ).
:- dynamic e_um/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Carregamento das bibliotecas

:- use_module( library( 'linda/client' ) ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Teoria representada na forma Agente :: Conhecimento



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado e_um: Agente,Classe -> {V,F}

e_um( avestruz, ave).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write( 'AVESTRUZ' ),nl,
    in(demo( avestruz,Questao ) ),
    write( 'demo( avestruz,Questao )' ),nl,
    demo(avestruz,Questao ),
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
%Extensao do predicado alimentacao: Avestruz,Alimentacao -> {V,F}

avestruz :: alimentacao( sementes ).
avestruz :: alimentacao( minhocas ).


%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::alimentacao(A)) :: (findall(A, Ar::alimentacao( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-alimentacao(A) :- nao(alimentacao(A)), nao(excecao(alimentacao(A))).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensao do predicado locomocao: Avestruz,Locomocao -> {V,F}

avestruz :: locomocao( terrestre ).


%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::locomocao(A)) :: (findall(A, Ar::locomocao( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-locomocao(A) :- nao(locomocao(A)), nao(excecao(locomocao(A))).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensao do predicado cobertura: Avestruz,Cobertura -> {V,F}

avestruz :: cobertura( penas ).


%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::cobertura(A)) :: (findall(A, Ar::cobertura( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-cobertura(A) :- nao(cobertura(A)), nao(excecao(cobertura(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensao do predicado reproducao: Avestruz,Reproducao -> {V,F}

avestruz :: reproducao( ovipara ).


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
