/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Ejercicio 1: Predicados sobre árboles.
   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/*
 * Define si algo es un árbol.
 */
arb(nil, _, nil) :- !.
arb(I, _, D) :- arbol(I), arbol(D).

/*
 * Verifica si x pertenece al árbol dado.
 * ?- x_pert_arb(2, arb(arb(nil, 1, arb(nil, 2, nil)), 4, arb(nil, 5, nil))). <- true.
 * ?- x_pert_arb(3, arb(arb(nil, 1, arb(nil, 2, nil)), 4, arb(nil, 5, nil))). <- false.
 */
x_pert_arb(X, arb(_, X, _)) :- !.
x_pert_arb(X, arb(I, _, D)) :-
    x_pert_arb(X, I), !;
    x_pert_arb(X, D), !.

/*
 * Cuenta el número de nodos que tiene un árbol
 * ?- nods_arb(arb(arb(nil, 1, arb(nil, 2, nil)), 4, arb(nil, 5, nil)), N). <- N = 4
 */
nods_arb(nil, 0) :- !.
nods_arb(arb(nil, _, nil), 1) :- !.
nods_arb(arb(I, _, D), N) :-
    nods_arb(I, N1),
    nods_arb(D, N2),
    N is N1 + N2 + 1.

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Ejercicio 2: Determinación de triángulos
   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/*
 * Identifica si tres números cumplen con la desigualdad del triángulo.
 */
desigualdad_del_triangulo(X, Y, Z) :-
    X + Y > Z,
    Y + Z > X,
    Z + X > Y.

/*
 * Predicado auxiliar para determinar que triángulo se forma con tres
 * números dados. Sólo podemos tener un triángulo isóceles cuando dos
 * lados son iguales, un triángulo equilátero cuando tres lados son
 * iguales y un triángulo escaleno cuando tres números son distintos y
 * satisfacen la desigualdad del triángulo.
 */
t_(X, Y, Z, 'No se puede formar un triángulo') :- not(desigualdad_del_triangulo(X, Y, Z)).
t_(X, Y, Z, 'Triangulo isóceles') :-
    desigualdad_del_triangulo(X, Y, Z),
    ((X = Y, X \= Z); (Y = Z, Y \= X); (Z = X, Z \= Y)), !.
t_(X, Y, Z, 'Triángulo equilatero') :-
    desigualdad_del_triangulo(X, Y, Z),
    (X = Y, Y = Z), !.
t_(X, Y, Z, 'Triángulo escaleno') :-
    desigualdad_del_triangulo(X, Y, Z),
    X \= Y, Y \= Z, !.

/*
 * Imprime que triángulo forman tres números si es que se forma alguno.
 */
triangulo(X, Y, Z) :-
    t_(X, Y, Z, Resultado),
    write(Resultado), !.

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Ejercicio 3: Predicados sobre listas.
   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/*
 * Cuenta el número de apariciones distintas de una lista.
 * ?- cuenta([a, b, c, d, e, f], N). <- N = 6
 * ?- cuenta([b, a, n, a, n, a], N). <- N = 3
 * ?- cuenta([a, b, b, a, c, c, d, d, d, e], N). <- N = 5
 */
cuenta([], 0) :- !.
cuenta([X|Xs], N) :- not(member(X, Xs)), cuenta(Xs, N1), N is N1 + 1, !.
cuenta([Y|Xs], N) :- member(Y, Xs), cuenta(Xs, N), !.

/*
 * Elimina los elementos duplicados de una lista.
 * ?- filtra([a, b, b, a, c, c, d, d, d, e], N). N = [b, a, c, d, e].
 */
filtra([], []) :- !.
filtra([X|Xs], Ys) :-
   member(X, Xs),
   !,
   filtra(Xs, Ys).
filtra([X|Xs], [X|Ys]) :-
   not(member(X, Xs)),
   filtra(Xs, Ys).

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Ejercicio 4: Suma de matrices
   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/*
 * Suma dos vectores representados como listas.
 */
suma([], [], []) :- !.
suma([A|As], [B|Bs], [A_plus_B|ABs]) :-
    A_plus_B is A + B,
    suma(As, Bs, ABs), !.

/*
 * Suma dos matrices representadas como listas de listas.
 * ?- sumamatriz([[1, 2], [3, 4]], [[4, 3], [2, 1]], Res). Res = [[5, 5], [5, 5]].
 */
sumamatriz([],[],[]) :- !.
sumamatriz([V_1|Vs1],[V_2|Vs2], [V_sum|V_sums]) :-
    suma(V_1, V_2, V_sum),
    sumamatriz(Vs1, Vs2, V_sums), !.


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Ejercicio 5: Función de Ackerman
   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/*
 * Función de Ackerman
 * ?- ackermann(1, 2, X). X = 4.
 */
ackermann(0,N,X) :-
    X is N+1, !.
ackermann(M, 0, X) :-
    M>0,
    M1 is M-1,
    ackermann(M1, 1, X), !.
ackermann(M, N, X) :-
    M>0,
    N>0,
    M1 is M-1,
    N1 is N-1,
    ackermann(M, N1, X1),
    ackermann(M1, X1, X), !.
