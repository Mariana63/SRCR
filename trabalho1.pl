:-set_prolog_flag(single_var_warnings,off).

sistema((1,3)).
sistema((1,9)).
sistema((2,3)).
sistema((5,4)).

insere(X,Y,[X|Y]).


apaga(X,[X|R],R). 
apaga(X,[Y|R1],[Y|R2]):- apaga(X,R1,R2). 

existe(Pp):-sistema(Pp).
mm(L):-insere(1,[2,3],L). 


pertence(X,[X|L]).
pertence(X,[Y|L]) :- X \== Y , pertence(X,L).

tamanho([],0).
tamanho([_|L],N):-tamanho(L,M), N is M+1.