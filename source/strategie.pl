%% *************************************************************************
%% *************************************************************************
%% 									STRATEGIES
%% *************************************************************************
%% *************************************************************************

delete_member([],_,[]) :- !.
delete_member([H | P], E, NewP) :-
			delete_member(P, E,NewP),
			E == H, !.

delete_member([H | P], E, [H | NewP]) :-
			delete_member(P, E,NewP),
			 E \== H, !.

%% ce predicat permet d'executer l'unification
%% suivant la strategie de premier choix
%% qui transforme le systeme en utilisant la 1ere regle applicable 
choix_premier([],[],_,_).
choix_premier([E | P], P, E, R) :-
			regle(E, R), !.

%% definition des poids des regles pour la strategie 
%% de choix pondere
poid(clean, 6).
poid(check, 5).
poid(const, 0).
poid(orient, 3).
poid(expand, 1).
poid(simplify, 4).
poid(clash, 5).
poid(decompose, 2).
poid(rename, 4).

%% ce predicat permet de recuperer la regle R de poid Poid
%% et extraire de P l'equation E dont la regle R est applicable
%% est renvoi le reste de systeme dans Q.
get_eq_rule(Poid, P, E, R, Q) :-
			poid(R,Poid),
			member(E,P),
			regle(E,R), !,
			delete_member(P, E, Q).

%% ce predicat permet de recuperer le poid max
%% des regles applicables.
poid_max(P, Max) :- 
			poid_max(_, Max, P).

poid_max([], _, []) :- !.
poid_max(Poids, Max, [E | P]) :- 
			poid_max(TmpPoids, _, P),
			regle(E,R), poid(R,Pi),
			append([Pi], TmpPoids, Poids),
			max_list(Poids, Max).

%% ce predicat permet d'executer l'unification
%% suivant la strategie de choix pondéré
choix_pondere([],[],_,_).
choix_pondere(P, Q, E, R) :-
			poid_max(P, Max),
			get_eq_rule(Max, P, E, R, Q).

%% ce predicat permet d'executer l'unification
%% suivant la strategie de choix randomisé
choix_random([],[],_,_) :- !.
choix_random(P, Q, E, R) :- 
			random_member(E, P), !,
			regle(E,R),
			delete_member(P, E, Q).

%% ce predicat permet de choisir la strategie de choix des regles
%% que l'algorithme d'unification peut suivre.
strategie(P, Q, E, R, pondere) :- 
			choix_pondere(P, Q, E, R), !.

strategie(P, Q, E, R, random) :- 
			choix_random(P, Q, E, R), !.

%% la strategie par default est choix_premier
%% elle consiste a choisir premiere regle applicable 
%% sur la premiere equation.
strategie(P, Q, E, R, _) :- 
			choix_premier(P, Q, E, R), !.