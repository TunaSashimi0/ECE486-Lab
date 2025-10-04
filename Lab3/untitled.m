load_system('lab03.slx');
% plot 1
omega_end = 0;
tau_end = 1;
K = 19.4;
K_r = 1.0309;
K_d = 0;
figure;
hold on;
simOut = sim('lab03.slx');
tout = simOut.get('tout');
omega = simOut.get('omega');
plot (tout, omega)

% plot 2
K = 1.0667;
K_r = 1.5625;
K_d = 0;
simOut = sim('lab03.slx');
plot (simOut.get('tout'), simOut.get('omega'))

% plot 3
K = 19.4;
K_r = 1.0309;
K_d = 0.0317;
simOut = sim('lab03.slx');
plot (simOut.get('tout'), simOut.get('omega'))
plot (simOut.get('tout'), 0.01*ones(size(simOut.get('tout'))), '--');
hold off;

title ('ω(t) for the disturbance response')
xlabel ('time t (s)');
ylabel ('\omega');
legend ('C1', 'C2', 'C3', 'Disturbance Reference')

figure;
% plot 1
omega_end = 1;
tau_end = 0;
K = 19.4;
K_r = 1.0309;
K_d = 0;
hold on
simOut = sim('lab03.slx');
tout = simOut.get('tout');
omega = simOut.get('omega');
yss = mean(omega(end - 4:end));
y_max = max(omega);
Mp = 100 * ((y_max-yss)/yss);

t_10index = find(omega > .1*yss, 1, 'first');
t_90index  = find (omega > .9*yss, 1, 'first');
tr = tout(t_90index )-tout(t_10index );
x = length(omega);
while (x >= 1) && ((omega(x) >= 0.95*yss) && (omega(x) <= 1.05*yss)) 
    x = x-1;
end 
ts = tout(x);

fprintf ('-----------Experimental Results for Controller 1:-------------\n')
fprintf ('Mp value is: %.6g\n', Mp);
fprintf ('Tr value is: %.6g\n', tr);
fprintf ('Ts value is: %.6g\n', ts);

plot (tout, omega);

% plot 2
K = 1.0667;
K_r = 1.5625;
K_d = 0;
simOut = sim('lab03.slx');
tout = simOut.get('tout');
omega = simOut.get('omega');
yss = mean(omega(end - 4:end));
y_max = max(omega);
Mp = 100 * ((y_max-yss)/yss);

t_10index = find(omega > .1*yss, 1, 'first');
t_90index  = find (omega > .9*yss, 1, 'first');
tr = tout(t_90index )-tout(t_10index );
x = length(omega);
while (x >= 1) && ((omega(x) >= 0.95*yss) && (omega(x) <= 1.05*yss)) 
    x = x-1;
end 
ts = tout(x);

fprintf ('-----------Experimental Results for Controller 2:-------------\n')
fprintf ('Mp value is: %.6g\n', Mp);
fprintf ('Tr value is: %.6g\n', tr);
fprintf ('Ts value is: %.6g\n', ts);

plot (tout, omega);

% plot 3
K = 19.4;
K_r = 1.0309;
K_d = 0.0317;
simOut = sim('lab03.slx');
tout = simOut.get('tout');
omega = simOut.get('omega');
yss = mean(omega(end - 4:end));
y_max = max(omega);
Mp = 100 * ((y_max-yss)/yss);

t_10index = find(omega > .1*yss, 1, 'first');
t_90index  = find (omega > .9*yss, 1, 'first');
tr = tout(t_90index )-tout(t_10index );
x = length(omega);
while (x >= 1) && ((omega(x) >= 0.95*yss) && (omega(x) <= 1.05*yss)) 
    x = x-1;
end 
ts = tout(x);

fprintf ('-----------Experimental Results for Controller 3:-------------\n')
fprintf ('Mp value is: %.6g\n', Mp);
fprintf ('Tr value is: %.6g\n', tr);
fprintf ('Ts value is: %.6g\n', ts);

plot (tout, omega);
plot (simOut.get('tout'), 1.0284*ones(size(simOut.get('tout'))),'--');

title ('ω(t) for the reference response')
xlabel ('time t (s)');
ylabel ('\omega');
legend ('C1', 'C2', 'C3', 'Overshoot Reference')
