load_system('block.slx');
simOut = sim('block');
t = simOut.get('tout');
y = simOut.get('y');
y_dot = simOut.get('y_dot');
figure
plot (t, y, t, y_dot, '--')
title ('All Integrator Block H1(s)')
xlabel ('Time t')
ylabel ('Value y')
legend('y', 'y_dot')


load_system("state_space.slx");
A = [-6 -25; 1 0];
B = [25; 0];
C = [1 0 ; 0 1];
D = [0; 0];
simOut = sim("state_space.slx");
t = simOut.get('tout');
y = simOut.get('y');
y_dot = simOut.get('y_dot');
figure
plot (t, y, t, y_dot, '--')
title('State-Sapce model of H1(s)');
xlabel ('Time t')
ylabel ('Value y')
legend('y', 'y_dot')


