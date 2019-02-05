%% *************************************************************************
%% *************************************************************************
%% 									SUBSTITUTION
%% *************************************************************************
%% *************************************************************************


%% substitution d'une variable X par un terme T dans uns systeme d'equation P
%% et renvoi le resultat dans un nouveau systeme Q.
substitution_sol(_, [], []):- !.
substitution_sol(X ?= T, [T1 ?= T2 | Rest], Q) :- 
			substitution_sol(X ?= T, Rest, Qres), 
			subs_term_sol(X,T, T2, T2res),
			append([T1 ?= T2res], Qres, Q), !.

%% ce predicat substitue chaque occurence de X dans un Term par le terme T 
%% et renvoi le resulat dans le terme TRes. 
subs_term_sol(X, T, Term, TRes) :- 
			compound(Term), 
			compound_name_arguments(Term, Name, LTerm), 
			subs_term_list(X,T,LTerm,LRes), 
			compound_name_arguments(TRes, Name, LRes), !.

%% subs_term(X, T, Term, T) and no TRes=T
subs_term_sol(X, T, Term, T) :- 
			X==Term, !.

%% subs_term(_, _, Term, Term) and no TRes=Term
subs_term_sol(_, _, Term, Term) :-  
			not(compound(Term)), !. 

%% ce predicat permet de mapper subs_term sur les elements d'une list
%% il est utilisé dans le cas où le Terme a une arité > 0.
subs_term_list_sol(_,_, [], []):- !. 
subs_term_list_sol(X,T, [ T1 | Rest ], Lres) :-
			subs_term_list_sol(X,T, Rest, TempL),
			subs_term_sol(X,T, T1, TempTerm),
			append([TempTerm], TempL, Lres), !.



%% substitution d'une variable X par un terme T dans uns systeme d'equation P
%% et renvoi le resultat dans un nouveau systeme Q.
substitution(_, [], []):- !.
substitution(X ?= T, [T1 ?= T2 | Rest], Q) :- 
			substitution(X ?= T, Rest, Qres), 
			subs_term(X,T, T1, T1res),
			subs_term(X,T, T2, T2res),
			X = T,
			append([T1res ?= T2res], Qres, Q), !.

%% ce predicat substitue chaque occurence de X dans un Term par le terme T 
%% et renvoi le resulat dans le terme TRes. 
subs_term(X, T, Term, TRes) :- 
			compound(Term), 
			compound_name_arguments(Term, Name, LTerm), 
			subs_term_list(X,T,LTerm,LRes), 
			compound_name_arguments(TRes, Name, LRes), !.

%% subs_term(X, T, Term, T) and no TRes=T
subs_term(X, T, Term, Tres) :- 
			X==Term, 
			Tres = T, !.

%% subs_term(_, _, Term, Term) and no TRes=Term
subs_term(_, _, Term, Tres) :-  
			not(compound(Term)),
			Tres = Term, !. 

%% ce predicat permet de mapper subs_term sur les elements d'une list
%% il est utilisé dans le cas où le Terme a une arité > 0.
subs_term_list(_,_, [], []):- !. 
subs_term_list(X,T, [ T1 | Rest ], Lres) :-
			subs_term_list(X,T, Rest, TempL),
			subs_term(X,T, T1, TempTerm),
			append([TempTerm], TempL, Lres), !.
