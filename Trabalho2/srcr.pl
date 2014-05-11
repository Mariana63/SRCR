:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).


:- op(900,xfy,'::').
:- dynamic '-'/1.
:- dynamic farmacia/2.
:- dynamic armazem/2.
:- dynamic medicamento/2.
:- dynamic data_colcoacao_mercado/5.
:- dynamic data_validade/5.
:- dynamic aplicacao_clinica/2.
:- dynamic apresentacao_farmaceutica/2.
:- dynamic preco_pvp/3.
:- dynamic preco_recomendado/3.
:- dynamic regime_especial/3.


%---------------------------------------------------------------------------- BASE CONHECIMENTO -------------------------------------------------------------------


%--------------------------------------------------------------------------------- FARMACIA -------------------------------------------------------------------------
%Extensao do predicado farmacia: Nome, Tipo -> {V,F,D}
farmacia('Estela', 0).
farmacia('Reis', 1).
farmacia('S. Victor',1).
                 
%% Invariantes %%       
+farmacia( F,T ) :: (solucoes( F, farmacia( F,_ )), S),
                  comprimento( S,N ), N == 1
                  ).

-farmacia( F,T ) :: -armazem( F,_ ).

%--------------------------------------------------------------------------------- ARMAZEM -------------------------------------------------------------------------
%Extensao do predicado armazem: Nome Farmacia, Nome Medicamento -> {V,F,D}
armazem('Estela', 'Magrix').
armazem('Reis', incerto).
armazem('S. Victor', incerto).

%% Invariantes %%
+armazem(F,M) :: (solucoes((F,M), armazem(F,M)),S),
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
+medicamento(M,P) :: (solucoes(M, medicamento(M,P)), S),
                   	 comprimento( S,N ), N == 1
                   	).
  
-medicamento(M,P) :: (-data_colocacao_mercado(M, DCD,DCM,DCA), data_validade(M,DVD,DVM,DVA),
                     -aplicacacao_clinica(M,AP), -apresentacao_farmaceutica(M,AF),
                     -preco_pvp(M,AF1,P1), -preco_recomendado(M,AF2,P2), regime_especial(M,AF3,P3)
                    ).
                   
%%  Conhecimento negativo %%
-medicamento(M,P) :- nao(medicamento(M,P)), nao(excepcao(medicamento(M,P))).

excepcao(medicamento('Voltaren',interdito)).
+medicamento(M,PA) :: (solucoes(PA, (medicamento('Voltaren',PA), nao(nulo(V))), [])).

%------------------------------------------------------------------------- DATA COLOCACAO MERCADO ----------------------------------------------------------------
%Extensao do predicado data_colocacao_mercado: Nome Medicamento, Data(dia, mes, ano) -> {V,F,D}
data_colocacao_mercado('Daflon', incerto, 05, 2014).
data_colocacao_mercado('Calde', 01, 04, 2013).
data_colocacao_mercado('Fagico', 01, 01, 2012).
data_colocacao_mercado('Egide', 10, 6, 2012).
data_colocacao_mercado('Magrix', 03, 02, 2012).
data_colocacao_mercado('Oceral', 10, 06, 2002).
data_colocacao_mercado('Parasin', incerto, 02, 1992).
data_colocacao_mercado('Pantozol', 11, 06, 2012).

%% Invariantes 

% Não há conhecimento repetido %
+data_colocacao_mercado(X,D,M,A) :: (solucoes((X,D,M,A),data_colocacao_mercado( X,D,M,A ), S),
                                comprimento( S,N ), N == 1
                                ).

% %
+data_colocacao_mercado(X,D,M,A) :: (medicamento(X)).


% Data de validade é superior à data de inserção %
+data_colocacao_mercado( X,D,M,A ) :: (
                                ( nao(data_validade(X,DI,MI,AI)) );
                                ( A>AI );
                                ( A==AI, M>MI );
                                ( A==AI, M==MI, D>DI )).
                                
+data_colocacao_mercado(X,D,M,A) :: (findall((Dia, Mes, Ano), (data_colocacao_mercado(X, Dia, Mes, Ano),
                                      (nao(nulo(Dia)); nao(nulo(Mes)); nao(nulo(Ano)))), [])).
                                      
%%   Conhecimento negativo
-data_colocacao_mercado(X,D,M,A) :- nao(data_colocacao_mercado(X,D,M,A)), nao(excepcao(data_colocacao_mercado(X,D,M,A))).

%%   Excepções

excepcao(data_colocacao_mercado(X,D,M,A)) :- data_colocacao_mercado(X, data_nula, data_nula, data_nula).
                                
excepcao(data_colocacao_mercado(X,D,M,A)) :- data_colocacao_mercado(X,incerto,M,A).
excepcao(data_colocacao_mercado(X,D,M,A)) :- data_colocacao_mercado(X,D,incerto,A).
excepcao(data_colocacao_mercado(X,D,M,A)) :- data_colocacao_mercado(X,D,M,incerto).
excepcao(data_colocacao_mercado(X,D,M,A)) :- data_colocacao_mercado(incerto,D,M,A).
excepcao(data_colocacao_mercado(X,D,M,A)) :- data_colocacao_mercado(X,incerto,incerto,incerto).

                               
                                
%------------------------------------------------------------------------------ DATA VALIDADE ----------------------------------------------------------------------
%Extensao do predicado data_validade: Nome Medicamento, Data(dia, mes, ano) -> {V,F,D}

data_validade('Daflon', 01, 01, 2016).
data_validade('Calde', 01, 02, 2017).
data_validade('Fagico', 04, 09, 2015).
data_validade('Egide', 01, 01, 2019).
data_validade('Magrix', incerto, 05, 2015).
data_validade('Oceral', 31, 12, 2015).
data_validade('Parasin', 15, 06, 2020).
data_validade('Pantozol', 11, 06, 2016).


%% Invariantes 

% Não há conhecimento repetido %
+data_validade(X,D,M,A) :: (solucoes((X,D,M,A),data_validade( X,D,M,A ), S),
                                comprimento( S,N ), N == 1
                                ).

%%
+data_validade(X,D,M,A) :: (medicamento(X)).


% Data de validade é superior à data de inserção %
+data_validade( X,D,M,A ) :: (
                                ( nao(data_colocacao_mercado(X,DI,MI,AI)) );
                                ( A>AI );
                                ( A==AI, M>MI );
                                ( A==AI, M==MI, D>DI )).

+data_validade(X,D,M,A) :: (solucoes((Dia, Mes, Ano), (data_validade(X, Dia, Mes, Ano)),
                                     (nao(nulo(Dia)); nao(nulo(Mes)); nao(nulo(Ano)))), [])).
                 
%%   Conhecimento negativo    %%
-data_validade(X,D,M,A) :- nao(data_validade(X,D,M,A)), nao(excepcao(data_validade(X,D,M,A))).

%%   Excepções    %%
excepcao(data_validade(X,D,M,A)) :- data_validade(X, data_nula, data_nula, data_nula).

excepcao(data_validade(X,D,M,A)) :- data_validade(X,incerto,M,A).
excepcao(data_validade(X,D,M,A)) :- data_validade(X,D,incerto,A).
excepcao(data_validade(X,D,M,A)) :- data_validade(X,D,M,incerto).
excepcao(data_validade(X,D,M,A)) :- data_validade(incerto,D,M,A).
excepcao(data_validade(X,D,M,A)) :- data_validade(X,incerto,incerto,incerto).



%-------------------------------------------------------------------------- APLICACAO CLINICA --------------------------------------------------------------------
%Extensao do predicado aplicacao_clinica: Nome Medicamento, Aplicacoes Clinicas -> {V,F,D}
aplicacao_clinica('Daflon', 'insuficiencia venosa').
aplicacao_clinica('Calde', 'suplemento').
aplicacao_clinica('Fagico', 'distúrbios gastrointestinais').
aplicacao_clinica('Egide', 'epilepsia').
aplicacao_clinica('Magrix', 'reduz colesterol e gordura').
aplicacao_clinica('Oceral', 'dermatofitoses').
aplicacao_clinica('Parasin', 'elimina parasitas').
aplicacao_clinica('Pantozol', 'ulceras').




%% Invariantes %%
+aplicacao_clinica(M,A) :: (solucoes((M,A), aplicacao_clinica(M,A)),S), comprimento(S,N), N == 1).
                

%% Conhecimento negativo %%
-aplicacao_clinica(M,A) :- nao(aplicacao_clinica(M,A)), nao(excecao(aplicacao_clinica(M,A))).


%% Excecoes %%
excecao(aplicacao_clinica(M,A)) :- aplicacao_clinica(M, incerto). 
excecao(aplicacao_clinica(M,A)) :- aplicacao_clinica(incerto, A).
excecao(aplicacao_clinica(A,B)) :- aplicacao_clinica(A, aplicacao_clinica_nula).




%--------------------------------------------------------------------------- APRESENTACAO FARMACEUTICA -----------------------------------------------------------------
%Extensao do predicado apresentacao_farmaceutica: Nome Medicamento, Apresentacao Farmaceutica -> {V,F,D}

apresentacao_farmaceutica('Calde', 'comprimidos').
apresentacao_farmaceutica('Fagico', 'xarope').
apresentacao_farmaceutica('Egide', 'comprimidos').
apresentacao_farmaceutica('Magrix', 'comprimidos').
apresentacao_farmaceutica('Oceral', 'creme').
apresentacao_farmaceutica('Parasin', 'suspensao oral').
apresentacao_farmaceutica('Pantozol', 'comprimidos').



%% Invariantes %%
+apresentacao_farmaceutica(M,A) :: (solucoes((M,A), apresentacao_farmaceutica(M,A)),S), comprimento(S,N), N == 1).
                


%% Conhecimento negativo %%
-apresentacao_farmaceutica(M,A) :- nao(apresentacao_farmaceutica(M,A)), nao(excecao(apresentacao_farmaceutica(M,A))).



%% Excecoes %%
excecao(apresentacao_farmaceutica(M,A)) :- apresentacao_farmaceutica(M, incerto). 
excecao(apresentacao_farmaceutica(M,A)) :- apresentacao_farmaceutica(incerto, A).
excecao(apresentacao_farmaceutica(A,B)) :- apresentacao_farmaceutica(A, apresentacao_farmaceutica_nula).






%--------------------------------------------------------------------------------- PRECO PVP -------------------------------------------------------------------------
%Extensao do predicado preco_pvp: Nome Medicamento, Apresentacao Farmaceutica, Preco -> {V,F,D}
preco_pvp('Daflon', 'comprimidos',80).
preco_pvp('Calde', 'comprimidos',50).
preco_pvp('Fagico', 'xarope',12).
preco_pvp('Egide', 'comprimidos',12).
preco_pvp('Magrix', 'comprimidos',33).
preco_pvp('Oceral', 'creme',20).
preco_pvp('Parasin', 'suspensao oral',7).
preco_pvp('Pantozol', 'comprimidos',52).

%% invariantes

+preco_pvp(M,A,P) :: (solucoes((M,A,P),preco_pvp( M,A,P ), S),
                                comprimento( S,N ), N == 1
                                ).
+preco_pvp(M,A,P) :: (medicamento(M), apresentacao_farmaceutica(M,A)).

%%   Conhecimento negativo
-preco_pvp(M,A,P) :- nao(preco_pvp(M,A,P)), nao(excepcao(preco_pvp(M,A,P))).

%% Excecoes

excepcao(preco_pvp(M,A,P)) :- preco_pvp(M,A, preco_nulo).
excepcao(preco_pvp(M,A,P)) :- preco_pvp(M,incerto,P).
excepcao(preco_pvp(M,A,P)) :- preco_pvp(incerto,A,P).
excepcao(preco_pvp(M,A,P)) :- preco_pvp(M,A,incerto).

%------------------------------------------------------------------------------- PRECO RECOMENDADO ---------------------------------------------------------------------
%Extensao do predicado preco_recomendado: Nome Medicamento, Apresentacao Farmaceutica, Preco -> {V,F,D}
preco_recomendado('Daflon', 'comprimidos',77).
preco_recomendado('Calde', 'comprimidos',40).
preco_recomendado('Fagico', 'xarope',10).
preco_recomendado('Egide', 'comprimidos',10).
preco_recomendado('Magrix', 'comprimidos',23).
preco_recomendado('Oceral', 'creme',14).
preco_recomendado('Parasin', 'suspensao oral',5).
preco_recomendado('Pantozol', 'comprimidos',45).

%% invariantes

+preco_recomendado(M,A,P) :: (solucoes((M,A,P),preco_recomendado( M,A,P ), S),
                                comprimento( S,N ), N == 1
                                ).
+preco_recomendado(M,A,P) :: (medicamento(M), apresentacao_farmaceutica(M,A)).

%%   Conhecimento negativo
-preco_recomendado(M,A,P) :- nao(preco_recomendado(M,A,P)), nao(excepcao(preco_recomendado(M,A,P))).

%% Excecoes

excepcao(preco_recomendado(M,A,P)) :- preco_recomendado(M,A, preco_nulo).
excepcao(preco_recomendado(M,A,P)) :- preco_recomendado(M,incerto,P).
excepcao(preco_recomendado(M,A,P)) :- preco_recomendado(incerto,A,P).
excepcao(preco_recomendado(M,A,P)) :- preco_recomendado(M,A,incerto).

%-------------------------------------------------------------------------------- REGIME ESPECIAL ----------------------------------------------------------------------
%Extensao do predicado regime_especial: Nome Medicamento, Apresentacao Farmaceutica, Preco -> {V,F,D}
regime_especial('Daflon', 'comprimidos',40).
regime_especial('Calde', 'comprimidos',20).
regime_especial('Fagico', 'xarope',5).
regime_especial('Egide', 'comprimidos',5).
regime_especial('Magrix', 'comprimidos',20).
regime_especial('Oceral', 'creme',10).
regime_especial('Parasin', 'suspensao oral',5).
regime_especial('Pantozol', 'comprimidos',40).

%% invariantes

+regime_especial(M,A,P) :: (solucoes((M,A,P),regime_especial( M,A,P ), S),
                                comprimento( S,N ), N == 1
                                ).
+regime_especial(M,A,P) :: (medicamento(M), apresentacao_farmaceutica(M,A)).

%%   Conhecimento negativo
-regime_especial(M,A,P) :- nao(regime_especial(M,A,P)), nao(excepcao(regime_especial(M,A,P))).

%% Excecoes

excepcao(regime_especial(M,A,P)) :- regime_especial(M,A, preco_nulo).
excepcao(regime_especial(M,A,P)) :- regime_especial(M,incerto,P).
excepcao(regime_especial(M,A,P)) :- regime_especial(incerto,A,P).
excepcao(regime_especial(M,A,P)) :- regime_especial(M,A,incerto).




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
demo(Questao, verdadeiro):- Questao.
demo(Questao, falso):- -Questao.
demo(Questao, desconhecido):- nao(Questao), nao(-Questao).



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



