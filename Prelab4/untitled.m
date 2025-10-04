S = load ('prelab4.mat');
Elect = S.Elect;
Iner = S.Iner;

% Part B
t_e = Elect(:,1);
v_o = Elect(:,2);

t_iner = Iner(:,1);
omega_iner = Iner(:,2);

Rs = 2.5;
Ra = 3.3;

Vss = mean(v_o(end-19:end));

tcut = 0.0005;
idx = find(t_e <= tcut);

y = log(Vss - v_o(idx));
x = t_e(idx);

p = polyfit(x, y, 1);
m = p(1);
bfit = p(2);
tau_e = -1 / m;
La = tau_e * (Ra + Rs);

fprintf('tau_e = %.6g s\n', tau_e);
fprintf('Estimated La = %.6g H\n', La);

% Plot
figure;
plot(x, y, 'bo', 'MarkerFaceColor','b');
hold on;
plot(x, polyval(p,x), 'Color','r');
xlabel('Time (s)');
ylabel('ln(V_{ss}-V_o(t))');
title('Part B: ln(V_{ss} - V_o(t)) vs t');
legend('data','linear fit');
set(gcf,'Position',[100 100 700 420]);


% Part D
c = 0.01093;
b = 3.5 * 10^-5;
z = omega_iner + c / b;
tmax_fit = min(t_iner(idxZ(end)), 3);
idx_fit = find( (t_iner <= tmax_fit) & (z > 0) );

x_iner = t_iner(idx_fit);
y_iner = log( z(idx_fit) );

p_iner = polyfit(x_iner, y_iner, 1);
slope_iner = p_iner(1);
J = b / (-slope_iner);

fprintf('Estimated J = %.6g kg*m^2\n', J);

% Plot
figure;
plot(x_iner, y_iner, 'bo', 'MarkerFaceColor','b');
hold on;
plot(x_iner, polyval(p_iner,x_iner), 'Color', 'r');
xlabel('Time (s)');
ylabel('ln(\omega(t) + c/b)');
title('Part D ln(\omega + c/b) vs t');
legend('data','linear fit');
set(gcf,'Position',[120 120 700 420]);


% Part E
Kv = 0.05473;
Ktau = Kv;
a2 = La * J;
a1 = Ra * J + La * b;
a0 = Ra * b + Ktau * Kv;

num2 = Ktau;
den2 = [a2, a1, a0];

% First order approx (L_a = 0)
num1 = Ktau;
den1 = [Ra * J, Ra * b + Ktau * Kv];

sys2 = tf(num2, den2);
sys1 = tf(num1, den1);

poles2 = roots(den2);
poles1 = roots(den1);

fprintf('Second order poles: %.6g , %.6g (rad/s)\n', poles2(1), poles2(2));
fprintf('First order pole: %.6g (rad/s)\n', poles1);

% Step responses overlay
figure;
[y2, t2] = step(sys2, tplot);
[y1, t1] = step(sys1, tplot);
plot(t2, y2); 
hold on;
plot(t1, y1, '--');
xlabel('Time (s)'); 
ylabel('Ω/V');
title('Step Response: \Omega(t)/V_i');
legend('Second order', 'First order)');
set(gcf,'Position',[140 140 900 420]);

w = logspace(0,4,1000); % 1 to 10k rad/s
figure;
[mag2,phase2] = bode(sys2, w);
[mag1,phase1] = bode(sys1, w);
mag2 = squeeze(mag2); 
mag1 = squeeze(mag1);
phase2 = squeeze(phase2); 
phase1 = squeeze(phase1);
subplot(2,1,1);
semilogx(w, 20*log10(mag2)); 
hold on;
semilogx(w, 20*log10(mag1), '--');
ylabel('Magnitude (dB)');
title('Bode Plot');
legend('Second order', 'First order');

subplot(2,1,2);
semilogx(w, phase2); 
hold on;
semilogx(w, phase1, '--');
xlabel('Frequency (rad/s)'); 
ylabel('Phase (deg)');
set(gcf,'Position',[160 160 900 700]);


