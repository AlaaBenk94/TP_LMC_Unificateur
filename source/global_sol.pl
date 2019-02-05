%% *************************************************************************
%% *************************************************************************
%% 								SOLUTION GLOBAL
%% *************************************************************************
%% *************************************************************************

%% predicat d'activation de desactivation de l'utilisation
%% de l'operateur d'unification interne de prolog "="
pl_unif_on :- assert(unif_on).
pl_unif_off :- retractall(unif_on).

%% ce predicat unifie une variable et un terme 
%% si l'unification interne et activé.
%% sinon rien est fait.
%% uni_fy(X ?= T) :- unif_on, !, X=T.
%% uni_fy(_).

%% les predicats get_sol, set_sol et update_sol permettent de gerer la solution
%% déclaré globalement.
get_sol(Sol) :- 
			%% not(unif_on),
			nb_getval(sol, Sol).

%% ce predicat permet de remplacer la valeur de solution
%% c'est la solution n'existe pas, elle va etre créée.
set_sol(Sol) :-
			%% not(unif_on),
			nb_setval(sol, Sol), !.
set_sol(_).

%% initialisation de la solution a vide
:- set_sol([]).

%% ce predicat permet de mettre a jour la solution global
%% en performant une substitution sur l'ancienne solution
update_sol(E) :-
			%% not(unif_on),
			nb_getval(sol, OldSol),
			substitution_sol(E,OldSol, NewSol),
			nb_setval(sol, [E | NewSol]), !.
update_sol(_).

%% le predicat qui permet d'afficher la solution
print_solu :-
			%% not(unif_on),
			get_sol(Sol),
			nl, print_sol(Sol), nl, !.
print_solu.

print_sol([]) :- !.
print_sol([E | P]) :-
			X ?= T = E,
			write(X), write(' = '), write(T), nl,
			print_sol(P).
