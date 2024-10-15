% Relación de parentesco
parent(mariana, jose).
parent(mariana, andres).
parent(mariana, fernando).
parent(mariana, camilo).
parent(carlos, jose).
parent(carlos, andres).
parent(carlos, fernando).
parent(carlos, camilo).
parent(jose, tomas).
parent(jose, pedro).
parent(jose, antonia).
parent(juliana, tomas).
parent(juliana, pedro).
parent(juliana, antonia).
parent(andres, luis).
parent(andres, lucas).
parent(andres, pilar).
parent(margarita, luis).
parent(margarita, lucas).
parent(margarita, pilar).
parent(fernando, aaron).
parent(fernando, ana).
parent(fernando, mateo).
parent(aida, aaron).
parent(aida, ana).
parent(aida, mateo).
parent(camilo, angel).
parent(camilo, aurora).
parent(camilo, samuel).
parent(maria, angel).
parent(maria, aurora).
parent(maria, samuel).

% Género
female(mariana).
female(juliana).
female(margarita).
female(aida).
female(maria).
female(antonia).
female(pilar).
female(ana).
female(aurora).

male(carlos).
male(jose).
male(andres).
male(fernando).
male(camilo).
male(tomas).
male(pedro).
male(luis).
male(lucas).
male(aaron).
male(mateo).
male(angel).
male(samuel).

% Reglas de parentesco
father(X, Y) :- parent(X, Y), male(X).
mother(X, Y) :- parent(X, Y), female(X).
brother(X, Y) :- parent(Z, X), parent(Z, Y), male(X), X \= Y.
sister(X, Y) :- parent(Z, X), parent(Z, Y), female(X), X \= Y.
grandfather(X, Y) :- parent(X, Z), parent(Z, Y), male(X).
grandmother(X, Y) :- parent(X, Z), parent(Z, Y), female(X).
uncle(X, Y) :- brother(X, Z), parent(Z, Y).
aunt(X, Y) :- sister(X, Z), parent(Z, Y).
cousin(X, Y) :- parent(Z, X), parent(W, Y), Z \= W, (brother(Z, W); sister(Z, W)).

% Nivel de consanguinidad
levelConsanguinity(X, Y, 1) :- father(X, Y).
levelConsanguinity(X, Y, 1) :- mother(X, Y).

levelConsanguinity(X, Y, 2) :- brother(X, Y).
levelConsanguinity(X, Y, 2) :- sister(X, Y).
levelConsanguinity(X, Y, 2) :- grandfather(X, Y).
levelConsanguinity(X, Y, 2) :- grandmother(X, Y).

levelConsanguinity(X, Y, 3) :- uncle(X, Y).
levelConsanguinity(X, Y, 3) :- aunt(X, Y).
levelConsanguinity(X, Y, 3) :- cousin(X, Y).

% Porcentaje de herencia
percentLegacy(1, 30).
percentLegacy(2, 20).
percentLegacy(3, 10).

% Distribución de herencia
legacyMoney(_, [], []).
legacyMoney(LegacyTotal, [Family|F], [Distribution|F2]) :-
    levelConsanguinity(Family, _, Level),
    percentLegacy(Level, Percent),
    Distribution is (LegacyTotal * (Percent / 100)),
    legacyMoney(LegacyTotal, F, F2).

% Predicado para distribuir herencia
distribute_legacy(LegacyTotal, Heirs) :-
    legacyMoney(LegacyTotal, Heirs, Distributions),
    write('Distributions: '), write(Distributions), nl.


