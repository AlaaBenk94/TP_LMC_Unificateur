%% *************************************************************************
%% *************************************************************************
%% 									REGLES
%% *************************************************************************
%% *************************************************************************

%% définition de predicat occur_check
%% true si la variable V existe dans le terme T 
%% false sinon.
occur_check(V,T) :-
			var(V),V == T.

occur_check(V,T) :-
			var(V),
			compound(T),
			arg(_,T,A),
			occur_check(V,A).

%% ce predicat permet de verifier si deux termes sont egaux
%% egaux = meme nom et meme arité. 
same(T1,T2) :- functor(T1,N,M), functor(T2,N,M).

%% definition de l'ensemble des regles.
regle(X ?= T, clean) :- 
			X==T, !.

regle(X ?= T,simplify) :- 
			var(X), atomic(T), !.

regle(X ?= T,expand) :- 
			var(X), compound(T), 
			not(occur_check(X,T)).

regle(X ?= T,check) :- 
			var(X), 
			occur_check(X,T), !.

regle(X ?= T,rename) :- 
			var(X), var(T), !.

regle(T1 ?= T2,decompose) :- 
			compound(T1), 
			compound(T2), 
			same(T1,T2), !.

regle(T ?= X,orient) :- 
			var(X), nonvar(T), !.

regle(T1 ?= T2,clash) :- 
			compound(T1), 
			compound(T2), 
			not(same(T1,T2)), !.

regle(T1 ?= T2, const) :-
			( (atomic(T1), nonvar(T2));
			 (atomic(T2), nonvar(T1)) ),
			T1 \== T2, !.
