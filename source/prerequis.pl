%% *************************************************************************
%% *************************************************************************
%% 									PREREQUIS
%% *************************************************************************
%% *************************************************************************

%% definition de nouvel operateur ?= "peut-il s'unifie avec"
%% en utilisant le predicat prédéfini op(Precedence, Type, Name).
:- op(20,xfy,?=).

%% ce predicat permet de nettoyer l'affichage.
clear :- tty_clear.

%% Prédicats d'affichage fournis
%% set_echo: ce prédicat active l'affichage par le prédicat echo
set_echo :- assert(echo_on).

%% clr_echo: ce prédicat inhibe l'affichage par le prédicat echo
clr_echo :- retractall(echo_on).

%% echo(T): si le flag echo_on est positionné, echo(T) affiche le terme T
%%          sinon, echo(T) réussit simplement en ne faisant rien.

echo(T) :- echo_on, !, write(T), flush.
echo(_).

%% affichage d'une étape d'algorithme
affichage(P,R,E) :- 
			echo("systeme : "), echo(P), echo("\n"), 
			echo(R), echo(" : "), echo(E), echo("\n").
