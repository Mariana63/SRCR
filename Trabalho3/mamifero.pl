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

e_um( mamifero,animal ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write( 'MAMIFERO' ),nl,
    in(demo( mamifero,Questao ) ),
    write( 'demo( mamifero,Questao )' ),nl,
    demo(mamifero,Questao ),
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
%Extensao do predicado alimentacao: Mamifero,Alimento -> {V,F}

mamifero :: alimentacao( herbivoro ).
mamifero :: alimentacao( carnivoro ).
mamifero :: alimentacao( omnivoro ).


%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::alimentacao(A)) :: (findall(A, Ar::alimentacao( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-alimentacao(A) :- nao(alimentacao(A)), nao(excecao(alimentacao(A))).




%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensao do predicado cobertura: Mamifero,Cobertura -> {V,F}

mamifero :: cobertura( pelos ).


%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::cobertura(A)) :: (findall(A, Ar::cobertura( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-cobertura(A) :- nao(cobertura(A)), nao(excecao(cobertura(A))).


% Exceçao %


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensao do predicado reproducao: Mamifero,Reproducao -> {V,F}

mamifero :: reproducao( placentaria ).
mamifero :: reproducao( marsupial ).


%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::reproducao(A)) :: (findall(A, Ar::reproducao( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-reproducao(A) :- nao(reproducao(A)), nao(excecao(reproducao(A))).


% Exceçao %




















ligar( QN ) :-
    linda_client( QN ).

qn( L ) :-
    bagof_rd_noblock( X,X,L ).
