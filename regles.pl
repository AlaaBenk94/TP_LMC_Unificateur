%% l'occur check
occur_check(X,Y) :- occurrences_of_var(X,Y,Count), Count\==0.

%% le predicat qui verifie si une regle s'applique.
regle(X ?= X, clean).
regle(X ?= T,rename) :- var(X), var(T).
regle(X ?= T,simplify) :- var(X), nonvar(T).
regle(X ?= T,expand) :- compound(T), occur_check(X,T).
regle(X ?= T,check) :- occur_check(X,T).
regle(X ?= T,decompose) :- functor(X,N,A), functor(T,N,A), A\==0.
regle(X ?= _,orient) :- nonvar(X).
regle(X ?= T,clash) :- functor(X,Nx,Ax), functor(T,Nt,At), (Nx\==Nt;Ax\==At). 