%% *************************************************************************
%% *************************************************************************
%% 								PROGRAMME PRINCIPALE
%% *************************************************************************
%% *************************************************************************

%% chargement d'algorithme d'unification.
:- [uni].


%% chargement de menu console
:- [cons_menu].

%% ce predicat permet de quitter le mainloop
%% selon la reponse d'utilisateur.
check_exit(non) :- clear, mainloop.
check_exit(_).

%% ce predicat permet de lancer la version Console
%% de l'unificateur.
run :- 
	pl_unif_off,
	clear,
	mainloop.

%% la boucle principale de programme Console.
mainloop :-
	read_info(S,P,T),
	print_sep,
	execute(P,S,T),
	print_solu,
	print_sep,
	ask_for_exit(Exit),
	check_exit(Exit).

%% ce predicat permet d'executer l'algorithme d'unification selon
%% 
execute(P, S, oui) :- 
			trace_unif(P,S).

execute(P, S, non) :- 
			unif(P,S).