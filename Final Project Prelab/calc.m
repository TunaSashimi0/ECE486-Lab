%% Part C
A = [-18 16 8; -29 27 13; 10 -10 -4];
B = [1; -3; -2];
K = place(A,B,[-2 -19 -38]);
fprintf ('The Gain K matrix is: ');
fprintf('%g ', K); 
fprintf ('\n');

%% Part D 
Acl = A - B*K;
eigAcl = eig(Acl);
fprintf ('The new poles are: ');
fprintf('%g ', eigAcl); 
fprintf ('\n');