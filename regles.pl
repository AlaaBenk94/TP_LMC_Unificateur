%% le predicat qui verifie si une regle s'applique.
regle(T1 ?= T2,rename) :- var(T1), var(T2).
regle(T1 ?= T2,simplify) :- var(T1), nonvar(T2).
%% regle(T1 ?= T2,expand) :- complex(T2), occur_check(T1,T2). % to review
%% regle(T1 ?= T2,check) :- occur_check(T1,T2). % to review
regle(T1 ?= T2,decompose) :- functor(T1,N,A), functor(T2,N,A), A\==0.
regle(T1 ?= _,orient) :- nonvar(T1).
regle(T1 ?= T2,clash) :- functor(T1,N1,A1), functor(T2,N2,A2), (N1\==N2;A1\==A2). 

%% un terme complexe
complex(T) :- functor(T,_,A), A\==0.