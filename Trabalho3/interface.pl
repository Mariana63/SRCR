:-op(900,xfy,'::').


demo(Agente,Questao,Resposta):-
	out(demo(Agente,Questao)),
	in(prova(Entidade,Resposta)).

	ligar(QN):- linda_client(QN).

	qn(L):-bagof_rd_noblock(X,X,L);