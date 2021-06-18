% ������ ��� ���� �������� � ���� �����������
% �� ����� ���������� ���� �������� � ���� ����������� ���������
% ����������� �� ���� �����. � �� ������������ ���� ���� �����, �������
% ����� ������������ �������� ��� �������. ���� �������� � ����� ��� ��
% ����� ������ ����������� ������, ��� �����������, ��� ����� �����������
% ������. ������� ������ ����������� �� ���� �������� � ����������� �
% ������� � �����������.

% ��� ��������� ��������� ����� ����������� ����� ������ �, 
% � ����, ���� ����� ����������� 5 �������� � 5 �����������, ��������� ������ B

domains
%���������� ����������� � ��������  �� ����������� ������ - �
number_missioner_�,number_cannibal_� = integer
%���������� ����������� � �������� �� ���� - B
number_missioner_B,number_cannibal_B = integer
%���������� ����������� � �������� �������������� � �����
missioner,cannibal,step = integer

facts
%������ ��������� ���� � ������� ������
game_state(step,symbol,number_missioner_B,number_cannibal_B,number_missioner_�,number_cannibal_�).

predicates
%��������� ���� �������� � ����� ���� < ��� �����������(������� ���������)
nondeterm boat_capacity(missioner,cannibal).
%�������� ��������
nondeterm play(step,symbol,integer, number_cannibal_B, number_missioner_�, number_cannibal_�).
%�������� �������
check(number_missioner_B,number_cannibal_B,number_missioner_�,number_cannibal_�).%�������� �� ����� ����������
nondeterm check1(number_missioner_B,number_cannibal_B,number_missioner_�,number_cannibal_�).
nondeterm check2(number_missioner_B,number_cannibal_B,number_missioner_�,number_cannibal_�).

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

%������� ��� ������� � �����.
boat_capacity(0,3).%1
boat_capacity(0,1).%2
%boat_capacity(2,0).%3 �� ����������
%boat_capacity(2,1).%4 �� ����������
%boat_capacity(0,3).%5
%boat_capacity(0,1).%6
boat_capacity(3,0).%7
boat_capacity(1,1).%8
%boat_capacity(3,0).%9
%boat_capacity(0,1).%10
%boat_capacity(0,3).%11
%boat_capacity(0,1).%12
boat_capacity(0,2).%13
%boat_capacity(1,0). �� ����������


%������� �������� 
play(_,_,5,5,0,0):- nl,write("�� ��������!!!"),nl.

%�������� �� ���� B
play(I,"��������",Number_missioner_B,Number_cannibal_B,Number_missioner_A,Number_cannibal_A):- 
boat_capacity(Missioner,Cannibal),
MB = Number_missioner_B + Missioner,
CB = Number_cannibal_B + Cannibal,
MA = Number_missioner_A - Missioner,
CA = Number_cannibal_A - Cannibal,
not(game_state(_,"����������",MB,CB,MA,CA)),
I1= I+1,
check(MB,CB,MA,CA),
check1(MB,CB,MA,CA),
check2(MB,CB,MA,CA),
assert(game_state(I1,"����������",MB,CB,MA,CA)),
play(I1,"����������",MB,CB,MA,CA),
write("���: ",I1,"\t��������  ","\n\t\t����������� �� ���� - ",MB,"  �������� �� ���� - ",CB,
"\n\t\t� ����� �-",Missioner," �- ",Cannibal,
"\n\t\t����������� � ���� - ",MA,"  �������� � ���� - ",CA),nl,nl.

%������� � �
play(I,"����������",Number_missioner_B,Number_cannibal_B,Number_missioner_A,Number_cannibal_A):- 
boat_capacity(Missioner,Cannibal),
MB = Number_missioner_B - Missioner,
CB = Number_cannibal_B - Cannibal,
MA = Number_missioner_A + Missioner,
CA = Number_cannibal_A + Cannibal,
not(game_state(_,"��������",MB,CB,MA,CA)),
I1= I+1,
check(MB,CB,MA,CA),
check1(MB,CB,MA,CA),
check2(MB,CB,MA,CA),
assert(game_state(I1,"��������",MB,CB,MA,CA)),
play(I1,"��������",MB,CB,MA,CA),
write("���: ",I1,"\t����������  ","\n\t\t����������� �� ���� - ",MB,"  �������� �� ���� - ",CB,
"\n\t\t� ����� �-",Missioner," �- ",Cannibal,
"\n\t\t����������� � ���� - ",MA,"  �������� � ���� - ",CA),nl,nl.


goal
write("�������� ������!!!"),nl,nl,
assert(game_state(0,"��������",0,0,5,5)),
play(0,"��������",0,0,5,5).