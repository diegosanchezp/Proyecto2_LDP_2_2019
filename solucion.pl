% Partir una lista dado un pivote
msplit(List, Pivot, Left, Right) :- append(Left, [Pivot|Right], List).

menor(ListIn, N, ListOut):- 
    convlist({N}/[X,Y]>>(X<N, Y is X), ListIn, ListOut).

menor_a_n(Flist, ListOut):- 
    convlist({Flist}/[In,Out]>>(msplit(Flist, In, _, Mlist),!, menor(Mlist, In, M), proper_length(M, Out)), Flist, ListOut).

getpos(NestedList, Pos):-
    convlist({NestedList}/[In, Out]>>(member(9,In),!, nth0(IndeY, In, 9), nth0(IndeX, NestedList, In),!, X is IndeX + 1, Y is IndeY + 1, Out = [X, Y]), NestedList, Pos).

manhattan(Pos, D):- 
    nth0(0,Pos,X), nth0(1,Pos,Y),
    D is abs(3-X) + abs(3-Y).

esResoluble(X):-
    % Hacer que X sea 1-D
    flatten(X, Flist),
    
    % Calcular cuantos numeros menores a N hay despues de la casilla actual
    menor_a_n(Flist, MenN),

    % Obtener posicion de casilla vacia
    getpos(X, Dpos),

    % Convertir Dpos a lista 1-D
    flatten(Dpos, Pos),

    % Calcular la distancia manhattan
    manhattan(Pos, D),

    % Añadir D a la lista MenN 
    append(MenN, [D], Menores),

    % Sumar menores a N
    sum_list(Menores, Suma),

    % Verificar si la suma es par
    mod(Suma, 2)=:=0.

% Probar el programa de esta manera
% esResoluble([[1,9,3],[5,2,6],[4,7,8]]). Retorna true o false.

% ========== Predicado rompecabezas ==========

/* Reemplazar elementos en una lista dado un indice 
   Funciona simililar a otros lenguajes como c++
   Por ejemplo para reemplazar el elemento en posicion 0 de un arreglo
   En c++
   array[0] = 1
   En prolog
   replace([1,2,3], 0, 9, R).
*/

replace(Lin, Index, Elem,R):- replaceAcc(Lin, Index,0,Elem, [],R).

% Si iterador es igual a al indice reemplazar
replaceAcc([_|Xs], Index, Index, Elem, Ant,R):- append(Ant, [Elem|Xs], R),!.

% Si no seguir aumentado indice y guardar elementos anteriores
replaceAcc([X|Xs], Index, Iter, Elem, Ant,R):- 
    Iter2 is Iter + 1,
    append(Ant, [X], NAnt),
    replaceAcc(Xs, Index, Iter2, Elem, NAnt,R).

% Reemplazar elemento de una matriz por otro
replaceM(TableroIn, [I,J], Elem, TableroOut):-
    % Obtener fila i
    nth0(I, TableroIn, FilaI),

    % Actualizar la fila
    replace(FilaI, J, Elem, R),

    % Actualizar Tablero
    replace(TableroIn, I, R, TableroOut).
% Ejemplo de llamada replaceM([[1,9,3],[5,2,6],[4,7,8]],[1,1], 7, TableroOut).

/* Intercambiar elementos de un tablero o matriz 
   Se intercambia o mueve el elemento en la pos [I1, J1] 
   a la posicion [I2,J2] y el elemento que estaba en la pos
   [I2, J2] se mueve a la pos [I1, J1]
*/
intercambiar(TableroIn, [I1, J1], [I2,J2], TableroOut):-
    % Obtener Filas
    nth0(I1,TableroIn, Fila1),
    nth0(I2, TableroIn, Fila2),

    % Obtener elemento J de las Filas
    nth0(J1, Fila1, Elem1),
    nth0(J2, Fila2, Elem2),
    
    % Realizar intercambio entre filas
    replaceM(TableroIn, [I2,J2], Elem1, To),
    replaceM(To, [I1, J1], Elem2, TableroOut).
    
% Ejemplo de llamada intercambiar([[1,9,3],[5,2,6],[4,7,8]], [0,1], [1,1], Tout).


