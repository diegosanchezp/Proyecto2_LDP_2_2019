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
