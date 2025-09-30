%% ECE 486
% Quadcopter Modeling and Simulation
%
% Acknowledgement: C. Carlson, R. Halverson, and R. Caverly provided
% the data collected from the Parrot Mambo during hover.


%% Vehicle Parameters
m = 65e-3;       % Mass, kg
g = 9.81;        % Gravitational constant, m/s^2
kT = [];         % Thrust coefficient, N
umax = 500;      % Maximum thrust input command.

%% Load hover data
load('MamboData');

%% Part A
% Plot altitude and desired altitude vs. time
% Add labels to the horizontal and vertical axes of your plot.
figure (1);
plot(t, h);
hold on;
plot(t, href);
legend('h','href','Location','best');
xlabel('Time (s)');
ylabel('Altitude (m)');
title('Altitude vs Time');
hold off;

%% Part B
u_mat = [u1; u2; u3; u4];   
u_average_per_motor = mean(u_mat);  
kT = m*g/4/u_average_per_motor;
a_max = (4*kT*umax - m*g)/m;

fprintf('Estimated kT = %.6e N per unit command\n', kT);
fprintf('Average motor command during hover (per motor) = %.3f\n', u_average_per_motor);
fprintf('Maximum upward acceleration with u_max = %.1f is a_max = %.3f m/s^2\n', umax, a_max);


%% Part C
% Simulate system with constant motor command to maintain hover.
% Plot altitude vs. time.
% Again, add labels to the horizontal and vertical axes of your plot.

h0 = 1;            % Initial altitude, m
hdot0 = 0;         % Initial altitude velocity, m/s
u = (m*g)/(4*kT);  % Throttle command, unitless
Tf = 20;            % Final simulation time, sec

assignin('base','m',m);
assignin('base','g',g);
assignin('base','kT',kT);
assignin('base','u',u);
assignin('base','h0',h0);
assignin('base','hdot0',hdot0);

sim('QuadcopterSim',[0 Tf]);

figure(2);
plot(tsim,h);
xlabel('Time, sec');
ylabel('Altitude, m');
title('Part C) Hover');
grid on;

%% Part D
% Modify Simulink diagram to include disturbance. Simulate and 
% plot altitude vs. time. 

h0 = 1;            % Initial altitude, m
hdot0 = 0;         % Initial altitude velocity, m/s
u = (m*g)/(4*kT);  % Throttle command, unitless
Tf = 20;            % Final simulation time, sec

assignin('base','m',m);
assignin('base','g',g);
assignin('base','kT',kT);
assignin('base','u',u);
assignin('base','h0',h0);
assignin('base','hdot0',hdot0);

sim('QuadcopterSimPartD',[0 Tf]);

figure(3);
plot(tsim,h);
xlabel('Time, sec');
ylabel('Altitude, m');
title('Part D) Hover With Disturbance');
grid on;