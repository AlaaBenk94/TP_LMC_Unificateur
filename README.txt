TP LMC : 
Realisation d'un algorithme d'unification de Martelli-Montanari sous prolog

Auteurs :
	BENKARRAD Alaa Eddine.
	HAFIANE Walid

Listing des fichiers : 
prerequis.pl 		contient la définition d’opérateur et les prédicats d’affichage 
regles.pl 			contient le prédicat qui définit l’ensemble des règles.
global_sol.pl 		contiennent les prédicats qui gèrent la variable globale de la solution.
substitution.pl 	contient les prédicats de substitution.
reduction.pl 		contient les prédicats nécessaires à la réduction.
strategies.pl 		contiennent des prédicats de stratégies.
uni.pl  			le fichier de l’unificateur, contient les prédicats d’unification.
cons_menu.pl 		contient les prédicats d’affichage et de saisie de l’interface console.
main.pl 			le programme principale qui contient la boucle.
README.txt  		contient des instruction sur l’utilisation d’unificateur
trace_tests.txt 	contient les traces d’exécutions de tous nos tests


Guide d'utilisation :
0. lancez le terminal.
1. se positioner dans le repertoire de programme source/.
2. lancez swi-prolog et charger le programme:
	a. directement : swipl main.pl
	b. indirectment : swipl puis dans prolog entrez [main].
3. lancez l'unificateur par le predicat:
trace_unif([ T11 ?= T12, T21 ?= T22, ... , Tn1 ?= Tn2]). ou encore
trace_unif([ T11 ?= T12, T21 ?= T22, ... , Tn1 ?= Tn2], <strategie>)
	strategie = {premier, pondere, random}.

si vouz voulez lancez l'unificateur sans trace, remplacez trace_unif par unif.
unif([ T11 ?= T12, T21 ?= T22, ... , Tn1 ?= Tn2]). ou encore
unif([ T11 ?= T12, T21 ?= T22, ... , Tn1 ?= Tn2], <strategie>)

Il existe un autre moyen pour lancer l'unificateur via l'interface console : 
introduisez le but suivant : 
	run.
Puis, suivez les instructions.