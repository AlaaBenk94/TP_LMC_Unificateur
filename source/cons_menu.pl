%% *************************************************************************
%% *************************************************************************
%% 								INTERFACE CONSOLE
%% *************************************************************************
%% *************************************************************************

%% ce predicat permet d'afficher l'entete de programme
print_header :-
	writeln("******************************************************************"),
	writeln("**************************** TP  LMC *****************************"),
	writeln("***************** Unificateur Martelli-Montanari *****************"),
	writeln("******************************************************************"),
	writeln("**** Realisé par : ***********************************************"),
	writeln("***** HAFIANE Walid **********************************************"),
	writeln("***** BENKARRAD Alaa Eddine **************************************"),
	writeln("******************************************************************"),
	nl.

%% ce predicat permet d'afficher un séparateur.
print_sep :-
	nl, writeln("******************************************************************"), nl.


%% recuperation de choix de strategie
strategy_number(50, pondere):-!.
strategy_number(51, random):-!.
strategy_number(_, premier).

ask_for_strategy(S) :-
	writeln("Tappez le # de la strategie que vous voulez"),
	writeln("      1 : choix premier"),
	writeln("      2 : choix pondéré "),
	writeln("      3 : choix randomisé "),
	writeln("Votre choix : "),
	prompt(_, ''),
	get_single_char(N),
	strategy_number(N,S), nl.

%% recuperation de system a resoudre
ask_for_system(P) :-
	writeln("Veuillez introduire votre systeme"),
	writeln("de la forme : [ t1 ?= t2 , ... ]."),
	writeln("Votre systeme :"),
	prompt(_, ''),
	read(P), nl.

%% recuperation d'activation de la trace.
act_trace(110, non) :- !.
act_trace(_,oui).

ask_for_trace(T) :- 
	writeln("Voulez vous une trace de resultat ? (o/n)"),
	writeln("Votre reponse : "),
	prompt(_, ''),
	get_single_char(N),
	act_trace(N,T).

%% recupere si l'utilisateur veut quitter le programme
quitter(110, non) :- !.
quitter(_, oui).

ask_for_exit(Response) :-
	writeln("Voulez vous quiter le progmame ? (o/n)."),
	writeln("Votre reponse : "),
	prompt(_, ''),
	get_single_char(R),
	quitter(R,Response).

%% ce predicat principalement lit les parametres d'entrée
%% sur le stream d'entrée standard.
read_info(S,P,T) :-
	print_header,
	ask_for_strategy(S),
	ask_for_trace(T),
	ask_for_system(P).