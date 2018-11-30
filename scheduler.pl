:-include('analyzer.pl').

%%%%%%%%%%% Scheduling classes %%%%%%%%%%%%%

% is true if L1 can be organized into academic years 1,2,3,4 as portrayed by the L2
%              where L2 is [Y1,Y2,Y3,Y4]
% schedule(L1, L2)
%% TODO
main(Deg):-
    welcome(Deg),
    c(Deg,deg,_),
    main_list(cogs_deg,R),
    course_load(1,C),
    schedule(R,1,0,C,[],X),
    print_schedule(X,1,0).

% is true if welcome message is written to the terminal
welcome(Deg):-
  write('Welcome to the University Agenda, this program allows you to schedule your 4 years of University courses based on your choices'),
  nl,
  write('Follow the instructions to plan your '),
  c(Deg,deg,X),
  atom_string(X,Y),
  write(Y),
  write(' degree'),
  nl,
  nl.

%% is true if Load is a list of terms where each item corresponds to the number of courses taken in a semester from 1st Year to 4th year.
%   Basically a function uses interface to ask user how many courses they would like to take each term from 1st to 4th year
% course_load(Y,Load)
course_load(5,[]).
course_load(Y,[L,L1|Load]):-
    term_load(Y,1,L),
    term_load(Y,2,L1),
    Y1 is Y+1,
    course_load(Y1,Load).

% helper function for course_load
% is true if Year Y number of courses Load for term T.
term_load(Y,T,Load):-
    write("How many courses would you like to take in Term "),
    write(T),
    write(" in Year "),
    write(Y),
    write("? "),
    nl,
    readln([Load|_]).

% recursive function for scheduling courses in L into terms according to order in which they have to be taken
%       L,Load,R are built through the recursion
%       Y and T are indicators for when the recursion should stop
% is true if courses in L can be organized into R
%               where R is a list of lists, where each sublist corresponds to a university term with the course load set in R. (Ri has course load Loadi)
%                     L is list of course load, where each item of list corresponds to one term
%                     Y is the tyear currently on
%                     T is the term currently on
% use schedule(L,1,0,Load,R) to start the recursion, along with an appropriate course list L and course load Load.
% schedule(L,Y,T,Load,R)
schedule(L,Y,_,_,R,R1):-
    Y=5,
    reverse(R,R1),
    fit(L),
    nl.

schedule(L,Y,T,[H|Load],Acc,R1):-
    dif(L,[]),
    Y<5,
    flatten(Acc,Acc1),
    meets_preReq(L,Acc1,NL),
    course_picker(NL,H,R),
    change_year(Y,T,Y1),
    T2 is mod(T+1,2),
    filter_course(L,R,L1),
    schedule(L1,Y1,T2,Load,[R|Acc],R1).

% if true if L is not empty and prints some statements along with the contents of L
fit([]).
fit(L):-
  dif(L,[]),
  write("You are beyond four years"),
  nl,
  write("Here are the courses we could not schedule based on your preferences: "),
  print(L),
  nl.

% is true if Year the year of the next semester is Y1, given current term.
%                 i.e. checks if year needs to be changed for the next semester.
%                 or if T is 1 (Term2), Y1 is Y+1.
% change_year(Y,T,Y1).
change_year(Y,0,Y).
change_year(Y,1,Y1):-
    Y1 is Y+1.

change_year_special(Y,0,Y).
change_year_special(Y,1,Y1):-
    Y1 is Y+1,
    nl.


% is true if at most C number of courses from L are found in R
%           i.e. function picks as many course as possible from L, where C is the maximum number of courses
% course_picker(L,C,R)
course_picker(L,C,L):-
    length(L,X),
    dif(C,0),
    X<C.
course_picker(L,C,R):-
    dif(C,0),
    length(L,X),
    C1 is C-1,
    X>C1,
    course_picker_h(L,C,R).

% helper for course_picker
% is true if C courses found in L are also found in R
course_picker_h(_,0,[]).
course_picker_h([H|T],C,[H|R]):-
    dif(C,0),
    C1 is C-1,
    course_picker_h(T,C1,R).
course_picker_h([_|T],C,R):-
    dif(C,0),
    course_picker_h(T,C,R).

% prints schedule
print_schedule([],_,_):-
    nl.
print_schedule([H|R],Y,T):-
    T1 is T+1,
    atom_string(Y,YS),
    atom_string(T1,TS),
    write("|  "),
    write("Year "),
    write(YS),
    write(" Term "),
    write(TS),
    write(": "),
    print1(H),
    write("  |"),
    change_year_special(Y,T,Y1),
    T2 is mod(T+1,2),
    print_schedule(R,Y1,T2).

% prints single Term
print1([H]):-
    atom_string(H,HS),
    write(HS).
print1([H|T]):-
    dif(T,[]),
    atom_string(H,HS),
    write(HS),
    write(", "),
    print1(T).

% is true of L1 meets pre-reqs for H.
meets_preReq([],_,[]).
meets_preReq([H|T],C,[H|R]):-
    not(c(H,prereq, _)),
    meets_preReq(T,C,R).
meets_preReq([H|T],C,[H|R]):-
    c(H,prereq, Pre),
    one_of(Pre,C),
    meets_preReq(T,C,R).
meets_preReq([H|T],C,R):-
    c(H,prereq, Pre),
    not(one_of(Pre,C)),
    meets_preReq(T,C,R).

% is true of L1 has at least one member of evey sublist in Pre.
one_of([],_).
one_of([[H|_]|R],L1):-
  member(H,L1),
  one_of(R,L1).
one_of([[H|T]|R],L1):-
  not(member(H,L1)),
  one_of([T|R],L1).
