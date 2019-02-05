%% *************************************************************************
%% *************************************************************************
%% 									REDUCTION
%% *************************************************************************
%% *************************************************************************

%% ce predicat permet de reorienter des terms
orient(T1 ?= T2, T2 ?= T1).

%% ce predicat permet de creer un systeme d'equation 
%% a partir de deux listes de terms L1 et L1 et renvoi le resultat
%% dans L.
system_eq([], [], []).
system_eq([T1 | L1], [T2 | L2], L) :- 
			system_eq(L1, L2, Ltemp),
			append([T1 ?= T2],Ltemp,L).

%% ce predicat permet de decomposer une equation T1 ?= T2
%% et renvoi le resultat dans Q sous forme d'une liste
decomp(T1 ?= T2, Q) :-
			compound_name_arguments(T1,_,A1),
			compound_name_arguments(T2,_,A2),
			system_eq(A1,A2,Q).

%% le predicat de reduction permet d'appliquer les regles décrit ci-dessus
%% sur l'equation E de systeme P et renvoie le resultat dans Q.
reduit(clean, E, P, P) :-
			affichage([E | P], clean, E), !.

reduit(rename, E, P, Q) :-
			affichage([E | P], rename, E),
			substitution(E,P,Q),
			update_sol(E), !.

reduit(simplify, E, P, Q) :-
			affichage([E | P], simplify, E),
			substitution(E,P,Q),
			update_sol(E), !.

reduit(expand, E, P, Q) :-
			affichage([E | P], expand, E),
			substitution(E,P,Q),
			update_sol(E), !.

reduit(check, E, P, ['⊥']) :-
			affichage([E | P], check, E),
			set_sol(['⊥']), !.

reduit(decompose, E, P, Q) :-
			affichage([E | P], decompose, E),
			decomp(E, Qtemp),
			append(Qtemp, P, Q), !.

reduit(orient, E, P, Q) :-
			affichage([E | P], orient, E),
			orient(E,Qtemp),
			append([Qtemp], P, Q), !.

reduit(clash, E, P, ['⊥']) :-
			affichage([E | P], clash, E),
			set_sol(['⊥']), !.

reduit(const, E, P, ['⊥']) :-
			affichage([E | P], const, E),
			set_sol(['⊥']), !.
