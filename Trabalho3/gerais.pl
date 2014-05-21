%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%-------------------------------------------------------------------------------- FUNÇÕES GERAIS ---------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

%% Nulo %%
% Extensao do meta-predicado nulo: Valor -> {V,F}
nulo(data_nula).
nulo(aplicacao_clinica_nula).
nulo(apresentacao_farmaceutica_nula).
nulo(preco_nulo).
nulo(interdito).

solucoes(X,Y,Z):- findall(X, Y, Z).

%Extensao do meta-predicado nao: Questao -> {V,F}
nao(Questao):- Questao, !, fail.
nao(Questao).

%Extensao do meta-predicado demo: Questao,Resposta -> {V,F}
demo( Questao,verdadeiro ) :-
    Questao.
demo( Questao,falso ) :-
    -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).

% Extensão do predicado comprimento: L, R -> {V, F}
comprimento([], 0) .
comprimento([H|T], R) :- comprimento(T, X), R is 1+X .

% Extensão do predicado que permite a evolução (inserção) de conhecimento: Termo -> {v, F}
evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

insercao(Termo):- assert(Termo).
insercao(Termo):- retract(Termo), !, fail.

teste([]).
teste([R|LR]):- R, teste(LR).

% Extensão do predicado que permite a remoção de conhecimento: Termo -> {v, F}
remocao( Termo ) :-
    solucoes( Invariante,-Termo::Invariante,Lista ),
    teste( Lista ),
    remover( Termo ).

remover( Termo ) :- retract( Termo ).