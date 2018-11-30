:- include('knowledgeBase.pl').

% This file contains all the requirments for Science Degree

% Biology
% is true if course c(X,Y,Z) counts towards the biology requirement

c(bio_req, counts, c(X,_,_)):-
  c(X, course, bio).
c(bio_req, counts, c(X,_,_)):-
  c(X, course, astr).
c(bio_req, counts, c(X,_,_)):-
  c(X, course, atsc).
c(bio_req, counts, c(X,_,_)):-
  c(X, course, eosc).
c(bio_req, description, "biological science credits").


% Physical Sciences
% is true if course c(X,Y,Z) counts towards the physical science requirement

c(phys_req, counts, c(X,_,_)):-
  c(X, course, phys),
	c(X, code, Y),
	Y>100,
  Y<200.
c(phys_req, counts, c(X,_,_)):-
  c(X, course, chem),
  c(X, code, Y),
  Y>100,
  Y<200.
c(phys_req, description, "physical science credits").


% Communications
% is true if course c(X,Y,Z) counts towards the communications requirement

c(comm_req, counts, c(X,_,_)):-
  c(X, course, engl),
  c(X, code, Y),
  Y>100,
  Y<121.
c(comm_req, counts, c(X,_,_)):-
  c(X, course, scie),
  c(X, code, 113).
c(comm_req, counts, c(X,_,_)):-
  c(X, course, scie),
  c(X, code, 300).
c(comm_req, counts, c(X,_,_)):-
  c(X, course, apsc),
  c(X, code, 176).
c(comm_req, counts, c(X,_,_)):-
  c(X, course, astu),
  c(X, code, 100).
c(comm_req, counts, c(X,_,_)):-
  c(X, course, astu),
  c(X, code, 150).
c(comm_req, counts, c(X,_,_)):-
  c(X, course, wrds),
  c(X, code, 150).
c(comm_req, description, "communication credits").

% Computational
% is true if course c(X,Y,Z) counts towards the computational requirement

c(comp_req, counts, c(X,_,_)):-
  c(X, course, math),
  c(X, code, Y),
  Y>99,
  not(Y=120),
  Y<185,
  0 is mod(Y,2).
c(comp_req, counts, c(X,_,_)):-
  c(X, course, stat).
c(comp_req, counts, c(X,_,_)):-
  c(X, course, cpsc).
c(comp_req, description, "computational credits").

% Arts requirements
% is true if course c(X,Y,Z) counts towards the computational requirement

c(arts_req, counts, c(X,_,_)):-
  c(X, faculty, arts).
c(arts_req, description, "arts credits").

% Science requirments

c(scie_req,counts,c(X,_,_)):-
  c(X,faculty,scie).
c(scie_req, description, "science credits").

% Lower-Level requirements

c(low_req,counts,c(X,_,_)):-
 c(X,code,Y),
 Y>99,
 Y<201.
 c(low_req, description, "lower level credits").

% Upper_Level requirements

c(upp_req,credits,48).
c(upp_req, description, "upper level credits").
c(upp_req,counts,c(X,_,_)):-
 c(X,code,Y),
 Y>299.

% Upper-Level SCIENCE requirements

% Upper-Level SCIENCE requirements
c(uppscie_req,credits,30).
c(uppscie_req,description,"upper level science credits").
c(uppscie_req,counts,c(X,_,_)):-
  c(X,code,Y),
  c(X,faculty,scie),
  Y>299.

% COGS requirements

c(cogsci_req,counts,L):-
  append([],
  [cs110,cs121,math100,math101,cogs200,cs210,cs221,ling100,
  phil220,stat200,cogs300,cogs303,cogs401,cogs402,cs312,cs320,
  cs322,phil451,psych365],L).

% Module requiremnts

c(csmod_req, counts, c(X,_,_)):-
  c(cogs_deg, mod, X),
  c(X, course, cpsc),
  c(X, code, Y),
  Y>399.

c(genmod_req, counts, c(X,_,_)):-
 c(cogs_deg, mod,X),
 c(X, course, Y),
 \+ Y=cpsc.

% Degree Requirements
c(cogs_deg, faculty, scie).
c(cogs_deg, deg, cogs).
% c(cogs_deg, requirements, []).

c(cogs_deg, requirements, R):-
  c(cogsci_req,counts,R).

%%%%%%%%%%% Function predicates start here
% Z = [[bio112, bio361, bio455, cogs200, cogs300, cogs303] ,[cogs401, cogs402, cs110, cs121, cs210] ,[cs221, cs312, cs320, cs322, cs422, cs430],[engl101, engl112, ling100, ling101, ling200, ling311], [math100, math101, math200, math220, math221, math302], [math303, math344, phil220, phil320, phil321], [phil333, phil451, phys100, phys108, psych365, stat200]]
% schedule([bio112, bio361, bio455, cogs200, cogs300, cogs303, cogs401, cogs402, cs110, cs121, cs210, cs221, cs312, cs320, cs322, cs422, cs430, engl101, engl112, ling100, ling101, ling200, ling311, math100, math101, math200, math220, math221, math302, math303, math344, phil220, phil320, phil321, phil333, phil451, phys100, phys108, psych365, stat200],1,0,[5,5,5,5,5,5,5,5],[],X).
% sort([bio112, bio361, bio455, cogs200, cogs300, cogs303, cogs401, cogs402, cs110, cs121, cs210, cs221, cs312, cs320, cs322, cs422, cs430, engl101, engl112, ling100, ling101, ling200, ling311, math100, math101, math200, math220, math221, math302, math303, math344, phil220, phil320, phil321, phil333, phil451, phys100, phys108, psych365, stat200],Z), schedule(Z,1,0,[5,5,5,5,5,5,5,5],[],X).
% X = schedule([bio112, bio361, bio455, cogs200, cogs300, cogs303, cogs401, cogs402, cs110, cs121, cs210, cs221, cs312, cs320, cs322, cs422, cs430, engl101, engl112, ling100, ling101, ling200, ling311, math100, math101, math200, math220, math221, math302, math303, math344, phil220, phil320, phil321, phil333, phil451, phys100, phys108, psych365, stat200],4,0,[5,5,5,5,5,5,5,5],[[math302, math344, phys108, stat200], [math200, math220, math221, phys100, psych365], [ling311, math101, phil320, phil321, phil333], [ling101, ling200, math100, phil220, phil451], [cs320, cs422, cs430, engl112, ling100], [cogs401, cogs402, cs221, cs312, cs322],[cogs300, cogs303, cs121, cs210, engl101], [bio112, bio361, bio455, cogs200, cs110]],_).
% sort_code([asia371, asia378, bio112, bio361, cogs200, cogs300, cogs303, cogs401, cogs402, cs110, cs121, cs210, cs221, cs312, cs320, cs322, cs422, cs430, engl101, engl112, ling100, ling101, ling200, ling311, math100, math101, math200, math220, math221, math302, math303, math344, phil220, phil333, phil451, phys100, phys102, phys108, phys210, phys410, psych365, stat200],Y),schedule(Y,1,0,[5,5,5,5,5,5,5,5],[],X), print_schedule(X,1,0).
% sort_code([cogs200, cogs300, cogs303, cogs401, cogs402, cs110, cs121, cs210, cs221, cs312, cs320, cs322, cs422, cs430, engl101, engl112, ling100, ling101, ling200, ling311, math100, math101, math200, math220, math221, math302, math303, math344, phil220, phil333, phil451, phys100, phys102, phys108, phys210, phys410, psych365, stat200],Y),schedule(Y,1,0,[5,5,5,5,5,5,5,5],[],X), print_schedule(X,1,0).


% is true if L3 is a list of courses that meet the given Deg requirements, where L3 is ordered by mergesort.
main_list(Deg, L3):-
    c(Deg,deg,_),
    c(Deg,requirements,B),
    course_list(Deg,B,L1),
    upper_req(Deg,L1,L2),
    sort_code(L2,L3).

% Degree requiremnts functions
% is true of degree (c(Deg,deg,_)) has requirements L where each tuple corresponds to a specific requirment and the %number of credits necessary for that requirement.
degree_req(Deg,L):-
    c(Deg,deg,_),
    c(Deg,faculty,scie),
    % c(Deg,requirements,R),
    append([[bio_req,3],
            [phys_req,3],
            [comm_req,6],
            [comp_req,9],
            [arts_req,18]
              ], [], L).

% is true if L2 is a list containing L, and  it meets the science upper level credit requirements.
upper_req(Deg, L, L2):-
      c(Deg,deg,_),
      c(Deg,faculty,scie),
      counter(upp_req,L,X),
      counter(uppscie_req,L,Y),
      c(upp_req, credits, X1),
      c(uppscie_req, credits, Y1),
      X2 is X1-X,
      Y2 is Y1-Y,
      course_list2([[upp_req, X2],[uppscie_req,Y2]],L,L2).


% is true if R is the list of course Deg needs to be completed
course_list(Deg,B,R):-
    c(Deg,deg,_),
    degree_req(Deg, L),
    updated_list(L,B,R1),
    course_list1(Deg,R1,R).

% helper for course_list
updated_list([],_,[]).
updated_list([[Req,Cr]|T],B,[[Req,N]|Rest]):-
    counter(Req,B,N1),
    N is Cr-N1,
    updated_list(T,B,Rest).

% updated_list([[bio_req,3],[phys_req,3],[comm_req,6],[comp_req,9],[arts_req,12]],[bio112,bio121],Z).
% [[bio_req,3],[phys_req,3],[comm_req,6],[comp_req,9],[arts_req,12]]

% helper for course_list
% is true if requirements listed in L1 are met by courses in L2
% course_list1(Deg,L1,L2).
course_list1(_,[],[]).
course_list1(Deg,L,R):-
  dif(L,R),
  c(Deg, requirements, R1),
  course_list2(L,R1,R).

% helper for course_list
% is true if the requirements listed in L1 are met by the return list L2, Acc is the accumulator used to recurse
% course_list2(L1,Acc,L2).
course_list2([],[],[]).
course_list2([],R,R):-
    dif(R,[]).
course_list2([[_,C]|T],Acc,R):-
  C<1,
  course_list2(T,Acc,R).
course_list2([[Req,Cr]|T],Acc,R):-
    Cr>0,
    atom_string(Cr,C1),
    c(Req, description, D),
    write("You need "),
    write(C1),
    write(" more "),
    write(D),
    nl,
    pick_one(Req,X,Acc),
    %% TODO add requirements to list
    prereqList([X],Acc,Q),
    append(Q,Acc,Acc1),
    % make them pick requirements here to add them to the list, and remove them from the credit count too
    counter(Req,Q,C),
    NCr is Cr-C,
    course_list2([[Req,NCr]|T],Acc1,R).

% interface function
% is true if H is a course that meets the requirement Req and is not in list L.
%     H is retrieved from all classes in file, which are filtered according to the requirement and limiting list.
%     User is asked to choose one from limited list.
pick_one(Req,H,L):-
  get_courses(Req,R),
  filter_course(R,L,R1),
  write("Pick one of the following: "),
  nl,
  print_list(R1),
  nl,nl,
  readln([H1|_]),
  write("You picked: "),
  atom_string(H1,X),
  write(X),
  nl,
  pick_check(H1,Req,R1,L,H).

% is true if the pick is correct.
%       when H is a member of L1 (a possible choice)
%           and H is not a member of L2 (not already in the list)
% recurses through pick_one until a correct input has been given
pick_check(H,_,L1,L2,H):-
  member(H,L1),
  not(member(H,L2)).
pick_check(H,Req,L1,L2,H1):-
    wrong_pick(H,L1,L2),
    write("Sorry your entry is invalid. Please try again."),
    nl,
    pick_one(Req,H1,L2).

% is true if the pick was wrong
%      if  H is not a member of L1 or it is a member of L2
wrong_pick(H,L1,_):-
    not(member(H,L1)).
wrong_pick(H,_,L2):-
    member(H,L2).

% is true if L has at least C credits that meet requirement Req
% counter(Req,L,C).
counter(_,[],0).
counter(X,[H|T],C):-
  length([H|T],L),
  L>0,
  c(X, counts, c(H,_,_)),
  counter(X,T,C1),
  c(H,credit,Cr),
  C is C1+Cr.
counter(X,[H|T],C):-
  length([H|T],L),
  L>0,
  \+c(X, counts, c(H,_,_)),
  counter(X,T,C).

%% is true if L contains all the courses in file that meet requirement Req
% get_courses(Req,L)

get_courses(Req,L):-
    findall(Course, c(Course,course,_), Collection),
    sort(Collection,L1),
    filter(Req, L1, L).

% get_courses(X,[phys101,phys102,phys108,phys118,phys153,phys158]).

%% is true if L2 is contains all elements of L1 tht are true for Req (meet requirement Req)
% filter_course(Req,L1,L2).
filter(_,[],[]).
filter(Req, [H|T], [H|R]):-
    c(Req,counts,c(H,course,_)),
    filter(Req, T, R).
filter(Req, [H|T], R):-
    not(c(Req,counts,c(H,course,_))),
    filter(Req, T, R).

%% is true if L3, contains all elements of L1 that are not already in L2.
% filter_course(L1,L2,L3).
filter_course([],_,[]).
filter_course([],[],[]).
filter_course([H|T],L,[H|R]):-
    not(member(H,L)),
    filter_course(T,L,R).
filter_course([H|T],L,R):-
    member(H,L),
    filter_course(T,L,R).

print_list([]).
print_list(L):-
    write("["),
    print_list2(L).

print_list2([H]):-
  atom_string(H,X),
  string_concat(X, "]", Y),
  write(Y).

print_list2([H|T]):-
  dif(T,[]),
  atom_string(H,X),
  write(X),
  nl,
  print_list2(T).

% prereqList is true if B is the list of pre-reqs that list A needs including itself.
prereqList(A,Acc,B):-
  prereqHelper(A,Acc,Z),
  removedups(Z,B).

% prereqList([cs422],Z).
% prereqList([cs430],Z).
% prereqList([phys410],Z).
% prereqList([cs322],Z).

% is true if there are no duplicates in the input list
removedups([],[]).
removedups([X|T],[X|Rest]):-
  not(member(X,T)),
  removedups(T,Rest).
removedups([X|T],Rest):-
  member(X,T),
  removedups(T,Rest).

% removedups([1,1,2,3],Z).
% removedups([1,2,1,3],Z).
% removedups([1,2,3,1],Z).

% prereqHelper produces a list of prerequisites of a course
%              and recursively finds the prerequisites of the
%              prerequisites
prereqHelper([],_,[]).
prereqHelper([X|T],Acc,[X|Rest]):-
  c(X,course,_),
  c(X,prereq,A),
  % pick one in A
  choose(A,Acc,Z),
  append(T,Z,E),
  prereqHelper(E,Acc,Rest).

% helper function to print a list
printer([]).
printer([X|Y]):- nl, write(X), printer(Y).

% helper function to choose from a list
choose([],_,[]).
choose([[Z|A]|T],Acc,Rest):-
  prepare([Z|A],Acc,[]),
  choose(T,Acc,Rest).
choose([[Z|A]|T],Acc,[X|Rest]):-
  prepare([Z|A],Acc,NL),
  length(NL,S),
  S>0,
  write('Pick on in the following list:'),
  printer(NL),
  nl,
  validate(X,NL),
  nl,
  choose(T,Acc,Rest).

% helper function to ask for user''s input
validate(X,NL):-
  readln([X1|_]),
  check_in(X1,NL,X).

% checks if H is a member of L
check_in(H,L,H):-
  member(H,L).
check_in(H,L,H1):-
  not(member(H,L)),
  write('Your choice is not legal, please try again'),
  nl,
  validate(H1,L).

% helper function to prepare list such that its elements are not already in accumulator
prepare([],_,[]).
prepare([X|T],Acc,[X|Rest]):-
  not(member(X,Acc)),
  prepare(T,Acc,Rest).
prepare([X|_],Acc,[]):-
  member(X,Acc).

% prepare([cs312,cs210,cs110],[cs110],Z).
% Z = [cs312, cs210]

% sort based on code instead of alphabet.
% is true if Y is sorted based on the course code from X
sort_code(X,Y):-
  maplist(replace_code,X,A),
  keysort(A,B),
  pairs_values(B,Y).

% heler function for sort_code
% is true if course name is replaced by code-name
replace_code(X,Y):-
  c(X,code,A),
  Y = A-X.
