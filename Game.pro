% Задача про пять людоедов и пять миссионеров
% Во время наводнения пять людоедов и пять миссионеров оказались
% отрезанными от суши водой. В их распоряжении была одна лодка, которая
% могла одновременно вместить трёх человек. Если людоедов в лодке или на
% любом берегу оказывается больше, чем миссионеров, они могут миссионеров
% съесть. Найдите способ переправить на сушу людоедов и миссионеров в
% целости и сохранности.

% Для понимания обозначим берег затопленный водой буквой А, 
% а сушу, куда нужно переправить 5 людоедов и 5 миссионеров, обозначим буквой B

domains
%Количество миссионеров и людоедов  на затопленном берегу - А
number_missioner_А,number_cannibal_А = integer
%Количество миссионеров и людоедов на суше - B
number_missioner_B,number_cannibal_B = integer
%Количество миссионеров и людоедов переправляемых в лодке
missioner,cannibal,step = integer

facts
%Хранит состояния игры в текущий момент
game_state(step,symbol,number_missioner_B,number_cannibal_B,number_missioner_А,number_cannibal_А).

predicates
%Проверяем чтоб Людоедов в лодке было < чем Миссионеров(правила перевозки)
nondeterm boat_capacity(missioner,cannibal).
%Основные действия
nondeterm play(step,symbol,integer, number_cannibal_B, number_missioner_А, number_cannibal_А).
%Проверка условий
check(number_missioner_B,number_cannibal_B,number_missioner_А,number_cannibal_А).%проверка на общее количество
nondeterm check1(number_missioner_B,number_cannibal_B,number_missioner_А,number_cannibal_А).
nondeterm check2(number_missioner_B,number_cannibal_B,number_missioner_А,number_cannibal_А).

clauses

check(Number_missioner_B,Number_cannibal_B,Number_missioner_A,Number_cannibal_A):-
All_missioner = Number_missioner_B + Number_missioner_A,   All_missioner = 5,
All_cannibal = Number_cannibal_B + Number_cannibal_A,      All_cannibal = 5,
Number_missioner_A >= 0, Number_cannibal_A>=0,
Number_missioner_B >= 0, Number_cannibal_B>=0.

check1(_,_,Number_missioner_A,Number_cannibal_A):-
Number_missioner_A > 0, Number_missioner_A >= Number_cannibal_A.

check1(_,_,Number_missioner_A,Number_cannibal_A):-
Number_missioner_A = 0, Number_cannibal_A >=0.

check2(Number_missioner_B, Number_cannibal_B,_,_):-
Number_missioner_B > 0, Number_missioner_B >= Number_cannibal_B .

check2(Number_missioner_B,Number_cannibal_B,_,_):-
Number_missioner_B = 0, Number_cannibal_B >=0.

%Правила для сидящих в лодке.
boat_capacity(0,3).%1
boat_capacity(0,1).%2
%boat_capacity(2,0).%3 Не использует
%boat_capacity(2,1).%4 Не использует
%boat_capacity(0,3).%5
%boat_capacity(0,1).%6
boat_capacity(3,0).%7
boat_capacity(1,1).%8
%boat_capacity(3,0).%9
%boat_capacity(0,1).%10
%boat_capacity(0,3).%11
%boat_capacity(0,1).%12
boat_capacity(0,2).%13
%boat_capacity(1,0). Не использует


%условие выйгрыша 
play(_,_,5,5,0,0):- nl,write("Мы выйграли!!!"),nl.

%Отправка на сушу B
play(I,"Посылаем",Number_missioner_B,Number_cannibal_B,Number_missioner_A,Number_cannibal_A):- 
boat_capacity(Missioner,Cannibal),
MB = Number_missioner_B + Missioner,
CB = Number_cannibal_B + Cannibal,
MA = Number_missioner_A - Missioner,
CA = Number_cannibal_A - Cannibal,
not(game_state(_,"Возвращаем",MB,CB,MA,CA)),
I1= I+1,
check(MB,CB,MA,CA),
check1(MB,CB,MA,CA),
check2(MB,CB,MA,CA),
assert(game_state(I1,"Возвращаем",MB,CB,MA,CA)),
play(I1,"Возвращаем",MB,CB,MA,CA),
write("Шаг: ",I1,"\tПосылаем  ","\n\t\tМиссионеров на суше - ",MB,"  Людоедов на суше - ",CB,
"\n\t\tВ лодке М-",Missioner," Л- ",Cannibal,
"\n\t\tМиссионеров в воде - ",MA,"  Людоедов в воде - ",CA),nl,nl.

%Возврат в А
play(I,"Возвращаем",Number_missioner_B,Number_cannibal_B,Number_missioner_A,Number_cannibal_A):- 
boat_capacity(Missioner,Cannibal),
MB = Number_missioner_B - Missioner,
CB = Number_cannibal_B - Cannibal,
MA = Number_missioner_A + Missioner,
CA = Number_cannibal_A + Cannibal,
not(game_state(_,"Посылаем",MB,CB,MA,CA)),
I1= I+1,
check(MB,CB,MA,CA),
check1(MB,CB,MA,CA),
check2(MB,CB,MA,CA),
assert(game_state(I1,"Посылаем",MB,CB,MA,CA)),
play(I1,"Посылаем",MB,CB,MA,CA),
write("Шаг: ",I1,"\tВозвращаем  ","\n\t\tМиссионеров на суше - ",MB,"  Людоедов на суше - ",CB,
"\n\t\tВ лодке М-",Missioner," Л- ",Cannibal,
"\n\t\tМиссионеров в воде - ",MA,"  Людоедов в воде - ",CA),nl,nl.


goal
write("Начинаем играть!!!"),nl,nl,
assert(game_state(0,"Посылаем",0,0,5,5)),
play(0,"Посылаем",0,0,5,5).