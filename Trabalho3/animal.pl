%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SISTEMAS DE REPRESENTACAO DE CONHECIMENTO E RACIOCINIO - LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

% Distribuicao da Computacao - LINDA

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 800,xfx,'::' ).
:- dynamic grupo/2.
:- dynamic tipo/2.
:- dynamic seres/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Carregamento das bibliotecas

:- use_module( library( 'linda/client' ) ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Teoria representada na forma Agente :: Conhecimento



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write( 'ANIMAL' ),nl,
    in(demo( animal,Questao ) ),
    write( 'demo( animal,Questao )' ),nl,
    demo(animal,Questao ),
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
%Extensao do predicado grupo: Animal,Grupo -> {V,F}

animal :: grupo( vertebrados ).
animal :: grupo( invertebrados ).


%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::grupo(A)) :: (findall(A, Ar::grupo( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%-- Conhecimento negativo --%
-grupo(A) :- nao(grupo(A)), nao(excecao(grupo(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado seres: Animal,Seres -> {V,F}

animal :: seres(eucariontes).
animal :: seres(procariontes).

%-------Invariantes--------%

%-- Conhecimento nao pode ser repetido --%
+(Ar::seres(A)) :: (findall(A, Ar::seres( A), S),
                                comprimento( S,N ), N == 1
                                ).

%-- Conhecimento negativo --%
-(Ar::seres(A)) :- nao(Ar::seres(A)), nao(excepcao(Ar::seres(A))).

-(Agente::Questao) :- nao(Agente::Questao), nao(excepcao(Agente::Questao)).
























ligar( QN ) :-
    linda_client( QN ).

qn( L ) :-
    bagof_rd_noblock( X,X,L ).
