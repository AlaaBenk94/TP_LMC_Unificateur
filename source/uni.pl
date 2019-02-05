%% *************************************************************************
%% *************************************************************************
%% 									UNIFICATION
%% *************************************************************************
%% *************************************************************************

%% chargement des prerequis
:- [prerequis].

%% chargment de la solution global
:- [global_sol].

%% chargement des regles 
:- [regles].

%% chargment de substitution
:- [substitution].

%% chargement de reduction
:- [reduction].

%% chargement des strategies
:- [strategie].

%% l'unification par default
%% ce predicat permet de lancer l'unification
%% de systeme P en utilisant les regles d'unification
unifie([]):- 
			!, writeln("\nYES\n").

unifie(['⊥']) :- 
			!, writeln("\nNO\n"), fail.

unifie(P) :-
			choix_premier(P, Q, E, R), !,
			reduit(R, E, Q, NewP),
			unifie(NewP).

%% l'unification suivant une strategie
%% ce predicat permet de lancer l'unification
%% de systeme P suivant une strategie S
unifie([],_) :- 
			!, writeln("\nYES\n").

unifie(['⊥'], _) :- 
			!, writeln("\nNO\n"), fail.

unifie(P, S) :- 
			strategie(P, Q, E, R, S), !,
			reduit(R, E, Q, NewP),
			unifie(NewP, S).

%% *************************************************************************
%% *************************************************************************
%% 									TRACE
%% *************************************************************************
%% *************************************************************************

%% unif(P,S) : permet d'executer l'unificateur SANS TRACE.
unif(P) :- 
			clr_echo,
			set_sol([]),
			unifie(P), !.
unif(_).

unif(P, S) :- 
			clr_echo,
			set_sol([]),
			unifie(P, S), !.
unif(_,_).

%% trace_unif(P,S) : permet d'executer l'unificateur AVEC TRACE.
trace_unif(P) :- 
			set_echo,
			set_sol([]),
			unifie(P), !.
trace_unif(_).

trace_unif(P, S) :- 
			set_echo,
			set_sol([]),
			unifie(P,S), !.
trace_unif(_,_).