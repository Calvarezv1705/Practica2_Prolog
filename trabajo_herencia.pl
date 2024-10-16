% Definición de relaciones familiares
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
parent(andres, luis).
parent(andres, lucas).
parent(andres, pilar).
parent(fernando, aaron).
parent(fernando, ana).
parent(fernando, mateo).
parent(camilo, angel).
parent(camilo, aurora).
parent(camilo, samuel).
parent(tomas, sofia).
parent(tomas, pepe).
parent(pedro, carla).
parent(pedro, juan).
parent(luis, daniel).
parent(luis, victoria).
parent(pilar, emilia).
parent(pilar, nicolas).
parent(aaron, isabella).
parent(aaron, gabriel).
parent(mateo, julieta).
parent(mateo, sebastian).
parent(angel, olivia).
parent(angel, neymar).
parent(aurora, luciana).
parent(aurora, diego).

% Género
female(mariana).
female(sofia).
female(carla).
female(victoria).
female(emilia).
female(isabella).
female(ana).
female(aurora).
female(olivia).
female(luciana).
female(julieta).

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
male(nicolas).

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
levelConsanguinity(X, Y, 1) :- father(Y, X).
levelConsanguinity(X, Y, 1) :- mother(Y, X).
levelConsanguinity(X, Y, 2) :- brother(X, Y).
levelConsanguinity(X, Y, 2) :- sister(X, Y).
levelConsanguinity(X, Y, 2) :- grandfather(Y, X).
levelConsanguinity(X, Y, 2) :- grandmother(Y, X).
levelConsanguinity(X, Y, 3) :- uncle(Y, X).
levelConsanguinity(X, Y, 3) :- aunt(Y, X).
levelConsanguinity(X, Y, 3) :- cousin(X, Y).

% Porcentaje de herencia
percentLegacy(1, 30).
percentLegacy(2, 20).
percentLegacy(3, 10).

% Distribución de herencia
legacyMoney(_, _, [], []).
legacyMoney(Testador, LegacyTotal, [Family|F], [Distribution|F2]) :-
    levelConsanguinity(Family, Testador, Level),
    percentLegacy(Level, Percent),
    Distribution is (LegacyTotal * (Percent / 100)),
    legacyMoney(Testador, LegacyTotal, F, F2).

% Predicado para distribuir herencia
distribute_legacy(Testador, LegacyTotal, Heirs) :-
    legacyMoney(Testador, LegacyTotal, Heirs, Distributions),
    write('Distributions for testador '), write(Testador), write(': '), write(Distributions), nl.

