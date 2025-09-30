% Part a
G = tf(5, [1 2 9]);
t = 0:0.001:10;      
[y_unit, t_unused] = step(G, t);
y_for_2 = 2 * y_unit;

% plot
figure;
plot(t, y_for_2);
xlabel('time (s)');
ylabel('y(t)');
title('Response to u(t)=2, t\in[0,10]');
grid on;

% Part b
G = tf(5, [1 2 9]);
t = 0:0.001:10;              
u = 4.*t + 2.*cos(3.*t);    
y = lsim(G, u, t);          

% plot
figure;
plot(t, y);
xlabel('time (s)');
ylabel('y(t)');
title('Response to u(t) = 4 t + 2 cos(3 t),  t\in[0,10]');
grid on;


