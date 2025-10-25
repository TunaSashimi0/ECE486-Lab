Ka = 2.4;
Kpot = 10/(2*pi);    
Ktach = 0.03;

P1 = 1.0472;
P2 = 0.8801;
K1_chosen = 10*P1;
K2_chosen = 10*P2;

A = 18*Ka;            
const_num_for_K1 = A * Kpot;    % 43.2 * Kpot  (this multiplies K1)
const_factor_K2 = 18*Ka*Ktach;  % 1.296

% --- Root locus #1: vary K1, hold K2 fixed at K2_chosen ---
K2 = K2_chosen;
num1 = const_num_for_K1;                % numerator (K1 will be the variable gain)
den1 = [0.2, (1 + const_factor_K2 * K2), 0];  % 0.2 s^2 + (1 + 1.296*K2) s + 0 -> no constant term

sys1 = tf(num1, den1);   % open-loop G(s) such that loop is K1*G(s)
figure(1);
rlocus(sys1);
title('Root locus: varying P1 (P2 fixed)');
xlabel('Real axis'); ylabel('Imag axis');
grid on; hold on;


% r1 = rlocus(sys1, K1_chosen);  
% plot(real(r1), imag(r1), 'rx', 'MarkerSize',10, 'LineWidth',2);
% legend('root locus','chosen K1 poles','Location','best');

zeta_desired = 0.5169308662051556;
omega_n_desired = 60;
sgrid(zeta_desired, omega_n_desired);



K1 = K1_chosen;
D = 18*Ka*K1*Kpot;  % constant term in characteristic: 18*Ka*K1*Kpot
% open-loop for K2 should be of form K2 * (1.296*s)/(0.2 s^2 + s + D)
num2 = const_factor_K2 * [1 0];   % numerator 1.296*s  -> [1.296 0]
den2 = [0.2, 1, D];               % denominator 0.2*s^2 + 1*s + D

sys2 = tf(num2, den2);  % open-loop G(s) such that loop is K2*G(s)
figure(2);
rlocus(sys2);
title('Root locus: varying P2 (P1 fixed)');
xlabel('Real axis'); ylabel('Imag axis');
grid on; hold on;

% compute and plot closed-loop poles for the chosen K2
% r2 = rlocus(sys2, K2_chosen);
% plot(real(r2), imag(r2), 'rx', 'MarkerSize',10, 'LineWidth',2);
% legend('root locus','chosen K2 poles','Location','best');

% Draw same damping/wn grid for comparison
sgrid(zeta_desired, omega_n_desired);

% Print numerical pole locations to command window
fprintf('Chosen K1 = %.6f, chosen K2 = %.6f\n', K1_chosen, K2_chosen);
fprintf('Closed-loop poles for chosen K1,K2 (figure 1 marker):\n');
disp(r1.');
fprintf('Closed-loop poles for chosen K1,K2 (figure 2 marker):\n');
disp(r2.');