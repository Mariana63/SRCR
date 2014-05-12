:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- op(900,xfy,'::').
:- dynamic '-'/1.
:- dynamic farmacia/2.
:- dynamic armazem/2.
:- dynamic medicamento/2.
:- dynamic data_colocacao_mercado/4.
:- dynamic data_validade/4.
:- dynamic aplicacao_clinica/2.
:- dynamic apresentacao_farmaceutica/2.
:- dynamic preco_pvp/3.
:- dynamic preco_recomendado/3.
:- dynamic regime_especial/3.

%---------------------------------------------------------------------------- BASE CONHECIMENTO ---------------------------------------------------------------------
%--------------------------------------------------------------------------------- FARMACIA -------------------------------------------------------------------------
%Extensao do predicado farmacia: Nome, Tipo -> {V,F,D}
farmacia('Estela', 0).
farmacia('Reis', 1).
farmacia('S. Victor',1).
                 
%% Invariantes %%       
+farmacia( F,T ) :: (solucoes( F, (farmacia( F,_ )), S),
                    comprimento( S,N ), N == 1
                    ).

-farmacia( F,T ) :: -armazem( F,M ).

%--------------------------------------------------------------------------------- ARMAZEM -------------------------------------------------------------------------
%Extensao do predicado armazem: Nome Farmacia, Nome Medicamento -> {V,F,D}
armazem('Estela', 'Magrix').
armazem('Reis', incerto).
armazem('S. Victor', incerto).

%% Invariantes %%
+armazem(F,M) :: (solucoes((F,M), (armazem(F,M)),S),
                          comprimento(S,N), N == 1
                ).
                
% Farmácia e medicamento existem %
+armazem(F,M) :: (farmacia(F), medicamento(M)).

%% Conhecimento negativo %%
-armazem(F,M) :- nao(armazem(F,M)), nao(excecao(armazem(F,M))).

%% Excecoes %%
excecao(armazem(F,M)) :- armazem(F, incerto). 
excecao(armazem(F,M)) :- armazem(incerto, M).
     
%--------------------------------------------------------------------------------- MEDICAMENTO -------------------------------------------------------------------------
%Extensao do predicado medicamento: Nome Medicamento, Principio Activo -> {V,F,D}
medicamento('Daflon', 'Diosmina').
medicamento('Calde', 'Carbonato de calcio').
medicamento('Fagico', 'Bromoprida').
medicamento('Egide', 'Topiramato').
medicamento('Magrix', 'Quitosana').
medicamento('Oceral', 'Oxiconazol').
medicamento('Parasin', 'Albendazol').
medicamento('Pantozol', 'Pantoprazol').
medicamento('Ben-u-ron', incerto).

%% Invariantes %%
+medicamento(M,P) :: (solucoes(M, (medicamento(M,P)), S),
                     comprimento( S,N ), N == 1
                    ).
  
-medicamento(M,P) :: (-data_colocacao_mercado(M, DCD,DCM,DCA), data_validade(M,DVD,DVM,DVA),
                     -aplicacacao_clinica(M,AP), -apresentacao_farmaceutica(M,AF),
                     -preco_pvp(M,AF1,P1), -preco_recomendado(M,AF2,P2), regime_especial(M,AF3,P3)
                    ).
                   
%%  Conhecimento negativo %%
-medicamento(M,P) :- nao(medicamento(M,P)), nao(excecao(medicamento(M,P))).

excecao(medicamento('Voltaren',interdito)).
+medicamento(M,PA) :: (solucoes(PA, (medicamento('Voltaren',PA), nao(nulo(V))), [])).

%------------------------------------------------------------------------- DATA COLOCACAO MERCADO ----------------------------------------------------------------
%Extensao do predicado data_colocacao_mercado: Nome Medicamento, Data(dia, mes, ano) -> {V,F,D}
data_colocacao_mercado('Daflon', incerto, 05, 2014).
data_colocacao_mercado('Calde', 01, 04, 2013).
data_colocacao_mercado('Fagico', 01, 01, 2012).
data_colocacao_mercado('Egide', 10, 6, 2012).
data_colocacao_mercado('Oceral', 10, 06, 2002).
data_colocacao_mercado('Parasin', incerto, 02, 1992).
data_colocacao_mercado('Pantozol', data_nula, data_nula, data_nula).

%-- Invariantes 
+data_colocacao_mercado(X,D,M,A) :: medicamento(X,_).                                
+data_colocacao_mercado(X,D,M,A) :: (solucoes(X, data_colocacao_mercado( X,D,M,A ), S),
                                    comprimento( S,N ), N == 1
                                    ).
+data_colocacao_mercado(X,D,M,A) :: (D>=0; D=<31; M>=0; M=<12; A>=0).                              

%%-- Conhecimento negativo
-data_colocacao_mercado(X,D,M,A) :- nao(data_colocacao_mercado(X,D,M,A)), nao(excecao(data_colocacao_mercado(X,D,M,A))).

%%-- Exceções
excecao(data_colocacao_mercado('Magrix',D,M,A)) :- D>4, D<13, M>3, M<5, A>2013, A<2015.

excecao(data_colocacao_mercado(X,D,M,A)) :- data_colocacao_mercado(X,incerto,M,A).
excecao(data_colocacao_mercado(X,D,M,A)) :- data_colocacao_mercado(X,D,incerto,A).
excecao(data_colocacao_mercado(X,D,M,A)) :- data_colocacao_mercado(X,D,M,incerto).
excecao(data_colocacao_mercado(X,D,M,A)) :- data_colocacao_mercado(incerto,D,M,A).
excecao(data_colocacao_mercado(X,D,M,A)) :- data_colocacao_mercado(X,incerto,incerto,incerto).
                     
%------------------------------------------------------------------------------ DATA VALIDADE ----------------------------------------------------------------------
%Extensao do predicado data_validade: Nome Medicamento, Data(dia, mes, ano) -> {V,F,D}

data_validade('Daflon', 01, 01, 2016).
data_validade('Fagico', 04, 09, 2015).
data_validade('Egide', 01, 01, 2019).
data_validade('Magrix', incerto, 05, 2015).
data_validade('Oceral', 31, 12, 2015).
data_validade('Parasin', data_nula, data_nula, data_nula).
data_validade('Pantozol', 11, 06, 2016).

%% Invariantes
+data_validade(X,D,M,A) :: (medicamento(X,_)).
+data_validade(X,D,M,A) :: (solucoes(X, data_validade( X,D,M,A ), S),
                            comprimento( S,N ), N == 1
                          ).
+data_validade( X,D,M,A ) :: (
                             ( (data_colocacao_mercado(X,DI,MI,AI)) );
                             ( A>AI );
                             ( A==AI, M>MI );
                             ( A==AI, M==MI, D>DI )).
                 
%%   Conhecimento negativo    %%
-data_validade(X,D,M,A) :- nao(data_validade(X,D,M,A)), nao(excecao(data_validade(X,D,M,A))).

%%   Excepções    %%
excecao(data_validade('Calde',03,10,A)) :- A>2001, A<2006.

excecao(data_validade(X,D,M,A)) :- data_validade(X,incerto,M,A).
excecao(data_validade(X,D,M,A)) :- data_validade(X,D,incerto,A).
excecao(data_validade(X,D,M,A)) :- data_validade(X,D,M,incerto).
excecao(data_validade(X,D,M,A)) :- data_validade(incerto,D,M,A).
excecao(data_validade(X,D,M,A)) :- data_validade(X,incerto,incerto,incerto).

%-------------------------------------------------------------------------- APLICACAO CLINICA --------------------------------------------------------------------
%Extensao do predicado aplicacao_clinica: Nome Medicamento, Aplicacoes Clinicas -> {V,F,D}
aplicacao_clinica('Daflon', 'insuficiencia venosa').
aplicacao_clinica('Calde', 'suplemento').
aplicacao_clinica('Fagico', 'distúrbios gastrointestinais').
aplicacao_clinica('Egide', 'epilepsia').
aplicacao_clinica('Magrix', 'reduz colesterol e gordura').
aplicacao_clinica('Oceral', incerto).
aplicacao_clinica('Parasin', 'elimina parasitas').
aplicacao_clinica('Pantozol', 'ulceras').

%% Invariantes %%
+aplicacao_clinica(M,AC) :: medicamento(M,_).
+aplicacao_clinica(M,A) :: (solucoes((M,A), (aplicacao_clinica(M,A)),S), comprimento(S,N), N == 1).
                
%% Conhecimento negativo %%
-aplicacao_clinica(M,A) :- nao(aplicacao_clinica(M,A)), nao(excecao(aplicacao_clinica(M,A))).

%% Excecoes %%
excecao(aplicacao_clinica(M,A)) :- aplicacao_clinica(M, incerto). 
excecao(aplicacao_clinica(M,A)) :- aplicacao_clinica(incerto, A).
excecao(aplicacao_clinica(A,B)) :- aplicacao_clinica(A, aplicacao_clinica_nula).

-aplicacao_clinica('Pantozol', 'Pes').

%--------------------------------------------------------------------------- APRESENTACAO FARMACEUTICA -----------------------------------------------------------------
%Extensao do predicado apresentacao_farmaceutica: Nome Medicamento, Apresentacao Farmaceutica -> {V,F,D}
apresentacao_farmaceutica('Calde', 'comprimidos').
apresentacao_farmaceutica('Calde', 'supositorio').
apresentacao_farmaceutica('Fagico', 'xarope').
apresentacao_farmaceutica('Egide', incerto).
apresentacao_farmaceutica('Magrix', 'comprimidos').
apresentacao_farmaceutica('Magrix', 'xarope').
apresentacao_farmaceutica('Oceral', 'creme').
apresentacao_farmaceutica('Oceral', 'comprimidos').
apresentacao_farmaceutica('Parasin', 'suspensao oral').

%% Invariantes %%
+apresentacao_farmaceutica(M,A) :: medicamento(M,_).
+apresentacao_farmaceutica(M,A) :: (solucoes((M,A), (apresentacao_farmaceutica(M,A)),S), comprimento(S,N), N < 4).
                
%% Conhecimento negativo %%
-apresentacao_farmaceutica(M,A) :- nao(apresentacao_farmaceutica(M,A)), nao(excecao(apresentacao_farmaceutica(M,A))).

%% Excecoes %%
excecao(apresentacao_farmaceutica(M,A)) :- apresentacao_farmaceutica(M, incerto). 
excecao(apresentacao_farmaceutica(M,A)) :- apresentacao_farmaceutica(incerto, A).
excecao(apresentacao_farmaceutica(A,B)) :- apresentacao_farmaceutica(A, apresentacao_farmaceutica_nula).

excecao(apresentacao_farmaceutica('Pantozol', interdito)).
+apresentacao_farmaceutica(M,V)::(solucoes(V, (apresentacao_farmaceutica('Pantozol',V), nao(nulo(V))) ,[])).

%--------------------------------------------------------------------------------- PRECO PVP -------------------------------------------------------------------------
%Extensao do predicado preco_pvp: Nome Medicamento, Apresentacao Farmaceutica, Preco -> {V,F,D}
preco_pvp('Daflon', 'comprimidos',80).
preco_pvp('Calde', incerto,50).
preco_pvp('Fagico', 'xarope',12).
preco_pvp('Magrix', 'comprimidos',33).
preco_pvp('Oceral', 'creme',20).
preco_pvp('Oceral', 'comprimidos',incerto).
preco_pvp('Parasin', 'suspensao oral',7).
preco_pvp('Pantozol', 'comprimidos',52).

%% invariantes
+preco_pvp(M,A,P) :: (medicamento(M,_), apresentacao_farmaceutica(M,A)).
+preco_pvp(M,A,P) :: (solucoes((M,A), (preco_pvp(M,A,P)),S), comprimento(S,N), N==1).

%%   Conhecimento negativo
-preco_pvp(M,A,P) :- nao(preco_pvp(M,A,P)), nao(excecao(preco_pvp(M,A,P))).

%% Excecoes
excecao(preco_pvp(M,A,P)) :- preco_pvp(M,A, preco_nulo).
excecao(preco_pvp(M,A,P)) :- preco_pvp(M,incerto,P).
excecao(preco_pvp(M,A,P)) :- preco_pvp(incerto,A,P).
excecao(preco_pvp(M,A,P)) :- preco_pvp(M,A,incerto).
preco_pvp('Egide', 'comprimidos',12).

acerca(X,Y) :- Z is X*0.95,
               W is X*1.05,
               Y=<W,
               Y>=Z.
excecao(preco_pvp('Egide', 'comprimidos',X)) :- acerca(100,X).

%------------------------------------------------------------------------------- PRECO RECOMENDADO ---------------------------------------------------------------------
%Extensao do predicado preco_recomendado: Nome Medicamento, Apresentacao Farmaceutica, Preco -> {V,F,D}
preco_recomendado('Daflon', 'comprimidos',77).
preco_recomendado('Calde', 'comprimidos',40).
preco_recomendado('Fagico', 'xarope',10).
preco_recomendado('Egide', 'comprimidos',10).
preco_recomendado('Magrix', 'comprimidos',23).
preco_recomendado('Parasin', 'suspensao oral',5).
preco_recomendado('Pantozol', 'comprimidos',45).

%% invariantes
+preco_recomendado(M,A,P) :: (solucoes((M,A),preco_recomendado( M,A,P ), S),
                              comprimento( S,N ), N == 1
                              ).
+preco_recomendado(M,A,P) :: (medicamento(M,_), apresentacao_farmaceutica(M,A), preco_pvp(M,A,P)).

%%   Conhecimento negativo
-preco_recomendado(M,A,P) :- nao(preco_recomendado(M,A,P)), nao(excecao(preco_recomendado(M,A,P))).

%% Excecoes

excecao(preco_recomendado(M,A,P)) :- preco_recomendado(M,A, preco_nulo).
excecao(preco_recomendado(M,A,P)) :- preco_recomendado(M,incerto,P).
excecao(preco_recomendado(M,A,P)) :- preco_recomendado(incerto,A,P).
excecao(preco_recomendado(M,A,P)) :- preco_recomendado(M,A,incerto).

preco_recomendado('Oceral', 'creme',incerto).
-preco_recomendado('Oceral', 'creme',15).

%-------------------------------------------------------------------------------- REGIME ESPECIAL ----------------------------------------------------------------------
%Extensao do predicado regime_especial: Nome Medicamento, Apresentacao Farmaceutica, Tipo, Preco -> {V,F,D}
regime_especial('Daflon', 'comprimidos', 1, 40).
regime_especial('Fagico', 'xarope', 2, incerto).
regime_especial('Egide', 'comprimidos', incerto, 5).
regime_especial('Magrix', 'comprimidos', 1, 20).
regime_especial('Oceral', 'creme', 3, incerto).
regime_especial('Parasin', 'suspensao oral', incerto, 5).

regime_especial('Calde', 'comprimidos', T, P) :- preco_pvp('Calde','comprimidos',X),
                                                 T == 1, P is X*0.90,
                                                 T == 2, P is X*0.80,
                                                 T == 3, P is X*0.70.

%% invariantes
+regime_especial(M,A,T,P) :: (solucoes((M,A,T),regime_especial( M,A,T,P ), S),
                              comprimento( S,N ), N == 1
                              ).
+regime_especial(M,A,T,P) :: (solucoes((M,A),regime_especial( M,A,T,P ), S),
                              comprimento( S,N ), N < 4
                              ).
+regime_especial(M,A,T,P) :: (medicamento(M,_), apresentacao_farmaceutica(M,A), preco_pvp(M,A,P)).

%%   Conhecimento negativo
-regime_especial(M,A,T,P) :- nao(regime_especial(M,A,T,P)), nao(excecao(regime_especial(M,A,T,P))).

%% Excecoes

excecao(regime_especial(M,A,T,P)) :- regime_especial(M,A,T,preco_nulo).
excecao(regime_especial(M,A,T,P)) :- regime_especial(M,incerto,T,P).
excecao(regime_especial(M,A,T,P)) :- regime_especial(incerto,A,T,P).
excecao(regime_especial(M,A,T,P)) :- regime_especial(M,A,T,incerto).
excecao(regime_especial(M,A,T,P)) :- regime_especial(M,A,incerto,P).

excecao(regime_especial('Pantozol', 'comprimidos',0,40)).
excecao(regime_especial('Pantozol', 'comprimidos',0,25)).

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