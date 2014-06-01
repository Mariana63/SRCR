% Distribuicao da Computacao - LINDA
% SICStus PROLOG: definicoes iniciais
:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- op(900,xfx,'::' ).
:- dynamic '-'/1.
:- dynamic p/2.

:- use_module(library('linda/client')).
:-use_module(library('system')).

qn(L) :- bagof_rd_noblock(X,X,L).

ligar(X):- linda_client(X).

p(Agente,Questao) :- out(demo(Agente,Questao)),
					 in(prova(X,S)),
					 write(S),nl.