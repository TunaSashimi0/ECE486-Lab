%% Cruise Control Problem

%% Vehicle Parameters
m = 2085;       % mass, kg
k = 40;         % throttle force constant, N/deg
b0 = -336.4;    % wind drag b0+b1*v where b0 is in N
b1 = 23.2;      % wind drag b0+b1*v where b1 is in N/(m/sec)
Froll = 228;    % Rolling resistance, N
%% A) Open-Loop Input
% Assume Fgrav=0 and compute the constant input required to 
% maintain vdes=29m/sec
ubar = 14.11;

%% B) Simulation with open-loop input and disturbance
% Simulation Parameters
Fgrav_final = 350;
Ki = 0;
Kp = 0;
% Simulate System
load_system('CruiseControlSim.slx');
simOut = sim('CruiseControlSim.slx');
figure;
hold on;
% Generate Plot
tout = simOut.get('tout');
v_out = simOut.get('v');
plot (tout, v_out);
xlabel ('Time (s)');
ylabel ('Velocity (m/s)');
title('V(t) Due to Gravitational Force');
hold off;

%% C) Selection of PI gains
Ki = 8.34;
Kp = 41.12;
Fgrav_final = 1400;

%% D) Simulation with PI and disturbance
simOut = sim('CruiseControlSim.slx');
figure;
hold on;
tout = simOut.get('tout');
v_out = simOut.get('v');
plot (tout, v_out);
xlabel ('Time (s)');
ylabel ('Velocity (m/s)');
title('V(t) with PI Controller');

u_out = simOut.get('u');
figure;
plot (tout, u_out);
xlabel('Time(s)');
ylabel ('Throttle input u (degree)');
title ('u(t) with PI Controller');

