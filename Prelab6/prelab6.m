% Prelab Lab 6 — Lead Controller Design
% Reproduce the numbers and plots from the prelab answers.

clear; close all; clc;
Kpot = 10/(2*pi);
K = 18;
Kamp = 2.4;
tau_m = 0.2;
Kp = Kpot*Kamp*K; % motor DC gain product
fprintf('Kp = %.8f\n', Kp);

s = tf('s');

%% (b) Uncompensated L(s) with Kc = 1
Kc = 1;
L_unc = Kc * (Kp) / ( s * (tau_m*s + 1) );
figure();
margin(L_unc); % returns gain margin, phase margin

% numerical values reported in prelab:
% wc ~ 18.21 rad/s, PM ~ 15.36 deg

%% increase Kc (pure gain) to get omega_c_target = 55 rad/s (uncompensated)
omega_target = 55;
% compute Kc required numerically
% Use margin on L_unc*Kc to find Kc such that magnitude at omega_target is 1
mag_at_target = abs(freqresp(L_unc, omega_target));
Kc_needed = 1 / mag_at_target;
fprintf('Pure-gain Kc needed for wc=55: Kc = %.6f\n', Kc_needed);



L_gain55 = Kc_needed * (Kp) / ( s * (tau_m*s + 1) );
figure();
margin(L_gain55);

%% (c) Plot example lead compensator Gc(s) = (0.1 s + 1)/(0.01 s + 1), Kc=1
Gc_example = (0.1*s + 1)/(0.01*s + 1);
figure; margin(Gc_example); grid on; title('Lead Compensator Gc(s) (Kc=1, 0.1s+1 / 0.01s+1)');

%% (d) Design lead compensator (my design)
% Chosen target: wc = 55 rad/s, desired lead ~ 45 deg, hence:
phi_max = 45*(pi/180); % rad
alpha = (1 - sin(phi_max)) / (1 + sin(phi_max)); % alpha < 1 for lead
omega_c = 55.4;
tau = 1/(omega_c * sqrt(alpha));
tau_z = tau;
tau_p = alpha * tau;
% compute Kc to make magnitude unity at wc
Gc_template = (tau_z*s + 1)/(tau_p*s + 1); % without Kc
mag_at_wc = abs(freqresp(Gc_template * (Kp) / ( s * (tau_m*s + 1) ), omega_c));
Kc_design = 1 / mag_at_wc;
fprintf('Lead design params:\n alpha=%.6f, tau_z=%.6e, tau_p=%.6e, Kc=%.6f\n', alpha, tau_z, tau_p, Kc_design);

Gc_design = Kc_design * (tau_z*s + 1)/(tau_p*s + 1);
L_comp = Gc_design * (Kp) / ( s * (tau_m*s + 1) );
figure; bode(L_comp); grid on; title('Compensated open-loop L_{comp}(j\omega)');
margin(L_comp);


% Closed-loop and step response
Tcl = feedback(L_comp, 1);
figure; step(Tcl); grid on; title('High DC Gain Lead Compensator Step Response');
stepinfo(Tcl)

% Root locus of the final design while varying the compensator gain Kc (0 to inf)
figure; rlocus( ( (tau_z*s + 1)/(tau_p*s + 1) ) * (Kp) / ( s * (tau_m*s + 1) ) );
title('Root locus of High DC Gain Compensator');

%% (e) Low DC gain controller verification
Gc_low = 0.40 * ( s/2.3 + 1 ) / ( s/92 + 1 );
L_low = Gc_low * (Kp) / ( s * (tau_m*s + 1) );
figure; bode(L_low); grid on; title('Low DC gain open-loop L_{low}');
margin(L_low);


Tcl_low = feedback(L_low, 1);
figure; step(Tcl_low); grid on; title('Closed-loop step response of low DC gain controller');
stepinfo(Tcl_low)
