load("y1.mat");
load("y2.mat");
load("y3.mat");
load("y4.mat");
load("y5.mat");
load("y6.mat");
load("y7.mat");
load("y8.mat");

plot(y1(:,1),y1(:,2));
hold on;
plot(y2(:,1),y2(:,2));
plot(y3(:,1),y3(:,2));
plot(y4(:,1),y4(:,2));
plot(y5(:,1),y5(:,2));
plot(y6(:,1),y6(:,2));
plot(y7(:,1),y7(:,2));
plot(y8(:,1),y8(:,2));
legend('\zeta = 2.0','\zeta = 1.5','\zeta = 1.0','\zeta = 0.8','\zeta = 0.7','\zeta = 0.5','\zeta = 0.3','\zeta = 0.2')
xlabel('Time \tau');
ylabel('Output Value y');
title ('Alex Ji, Sanay Doshi Lab 1 Plot')

% compute theoritical and actual value for each Mp, ts, tr:

omega_n = 1;

% \zeta = 2.0
zeta = 2.0;
theoretical_Mp = 0;
theoretical_tr = (4.7 .* zeta - 1.2)./omega_n;
theoretical_ts = (6.6 .* zeta - 1.6)./omega_n;
yss  = mean(y1(end-9:end,2)); 
ymax = max(y1(:,2));                   
actual_mp = (ymax - yss) / yss;
actual_mp_percent = actual_mp * 100;

S = stepinfo (y1(:,2), y1(:,1));
actual_tr = S.RiseTime;
actual_ts = S.SettlingTime;
fprintf(['\\zeta = %f, theoretical Mp value = %f, actual Mp value = %f, theoretical' ...
    ' tr value = %f, actual tr value = %f, theoretical ts value = %f, actual ts value = %f\n'] ...
    ,zeta, theoretical_Mp, actual_mp_percent, theoretical_tr, actual_tr, theoretical_ts, actual_ts);

% \zeta = 1.5
zeta = 1.5;
theoretical_Mp = 0;
theoretical_tr = (4.7 .* zeta - 1.2)./omega_n;
theoretical_ts = (6.6 .* zeta - 1.6)./omega_n;
yss  = mean(y2(end-9:end,2)); 
ymax = max(y2(:,2));                   
actual_mp = (ymax - yss) / yss;
actual_mp_percent = actual_mp * 100;

S = stepinfo (y2(:,2), y2(:,1));
actual_tr = S.RiseTime;
actual_ts = S.SettlingTime;
fprintf(['\\zeta = %f, theoretical Mp value = %f, actual Mp value = %f, theoretical' ...
    ' tr value = %f, actual tr value = %f, theoretical ts value = %f, actual ts value = %f\n'] ...
    ,zeta, theoretical_Mp, actual_mp_percent, theoretical_tr, actual_tr, theoretical_ts, actual_ts);


% \zeta = 1.0 
zeta = 1.0;
theoretical_Mp = 0;
theoretical_tr = (1.2 - 0.45 .* zeta + 2.6 .* zeta.^2)./omega_n;
theoretical_ts = (6.6 .* zeta - 1.6)./omega_n;
yss  = mean(y3(end-9:end,2)); 
ymax = max(y3(:,2));                   
actual_mp = (ymax - yss) / yss;
actual_mp_percent = actual_mp * 100;

S = stepinfo (y3(:,2), y3(:,1));
actual_tr = S.RiseTime;
actual_ts = S.SettlingTime;
fprintf(['\\zeta = %f, theoretical Mp value = %f, actual Mp value = %f, theoretical' ...
    ' tr value = %f, actual tr value = %f, theoretical ts value = %f, actual ts value = %f\n'] ...
    ,zeta, theoretical_Mp, actual_mp_percent, theoretical_tr, actual_tr, theoretical_ts, actual_ts);


% \zeta = 0.8 
zeta = 0.8;
theoretical_Mp = exp(-pi .* zeta ./ sqrt(1 - zeta.^2)) * 100;;
theoretical_tr = (1.2 - 0.45 .* zeta + 2.6 .* zeta.^2)./omega_n;
theoretical_ts = (6.6 .* zeta - 1.6)./omega_n;
yss  = mean(y4(end-9:end,2)); 
ymax = max(y4(:,2));                   
actual_mp = (ymax - yss) / yss;
actual_mp_percent = actual_mp * 100;

S = stepinfo (y4(:,2), y4(:,1));
actual_tr = S.RiseTime;
actual_ts = S.SettlingTime;
fprintf(['\\zeta = %f, theoretical Mp value = %f, actual Mp value = %f, theoretical' ...
    ' tr value = %f, actual tr value = %f, theoretical ts value = %f, actual ts value = %f\n'] ...
    ,zeta, theoretical_Mp, actual_mp_percent, theoretical_tr, actual_tr, theoretical_ts, actual_ts);

% \zeta = 0.7 
zeta = 0.7;
theoretical_Mp = exp(-pi .* zeta ./ sqrt(1 - zeta.^2)) * 100;;
theoretical_tr = (1.2 - 0.45 .* zeta + 2.6 .* zeta.^2)./omega_n;
theoretical_ts = (6.6 .* zeta - 1.6)./omega_n;
yss  = mean(y5(end-9:end,2)); 
ymax = max(y5(:,2));                   
actual_mp = (ymax - yss) / yss;
actual_mp_percent = actual_mp * 100;

S = stepinfo (y5(:,2), y5(:,1));
actual_tr = S.RiseTime;
actual_ts = S.SettlingTime;
fprintf(['\\zeta = %f, theoretical Mp value = %f, actual Mp value = %f, theoretical' ...
    ' tr value = %f, actual tr value = %f, theoretical ts value = %f, actual ts value = %f\n'] ...
    ,zeta, theoretical_Mp, actual_mp_percent, theoretical_tr, actual_tr, theoretical_ts, actual_ts);


% \zeta = 0.5 
zeta = 0.5;
theoretical_Mp = exp(-pi .* zeta ./ sqrt(1 - zeta.^2)) * 100;;
theoretical_tr = (1.2 - 0.45 .* zeta + 2.6 .* zeta.^2)./omega_n;
theoretical_ts = -0.5 ./ (zeta .* omega_n) .* log((1-zeta.^2)./400);
yss  = mean(y6(end-9:end,2)); 
ymax = max(y6(:,2));                   
actual_mp = (ymax - yss) / yss;
actual_mp_percent = actual_mp * 100;

S = stepinfo (y6(:,2), y6(:,1));
actual_tr = S.RiseTime;
actual_ts = S.SettlingTime;
fprintf(['\\zeta = %f, theoretical Mp value = %f, actual Mp value = %f, theoretical' ...
    ' tr value = %f, actual tr value = %f, theoretical ts value = %f, actual ts value = %f\n'] ...
    ,zeta, theoretical_Mp, actual_mp_percent, theoretical_tr, actual_tr, theoretical_ts, actual_ts);


% \zeta = 0.3 
zeta = 0.3;
theoretical_Mp = exp(-pi .* zeta ./ sqrt(1 - zeta.^2)) * 100;;
theoretical_tr = (1.2 - 0.45 .* zeta + 2.6 .* zeta.^2)./omega_n;
theoretical_ts = -0.5 ./ (zeta .* omega_n) .* log((1-zeta.^2)./400);
yss  = mean(y7(end-9:end,2)); 
ymax = max(y7(:,2));                   
actual_mp = (ymax - yss) / yss;
actual_mp_percent = actual_mp * 100;

S = stepinfo (y7(:,2), y7(:,1));
actual_tr = S.RiseTime;
actual_ts = S.SettlingTime;
fprintf(['\\zeta = %f, theoretical Mp value = %f, actual Mp value = %f, theoretical' ...
    ' tr value = %f, actual tr value = %f, theoretical ts value = %f, actual ts value = %f\n'] ...
    ,zeta, theoretical_Mp, actual_mp_percent, theoretical_tr, actual_tr, theoretical_ts, actual_ts);


% \zeta = 0.2 
zeta = 0.2;
theoretical_Mp = exp(-pi .* zeta ./ sqrt(1 - zeta.^2)) * 100;;
theoretical_tr = (1.2 - 0.45 .* zeta + 2.6 .* zeta.^2)./omega_n;
theoretical_ts = -0.5 ./ (zeta .* omega_n) .* log((1-zeta.^2)./400);
yss  = mean(y8(end-9:end,2)); 
ymax = max(y8(:,2));                   
actual_mp = (ymax - yss) / yss;
actual_mp_percent = actual_mp * 100;

S = stepinfo (y8(:,2), y8(:,1));
actual_tr = S.RiseTime;
actual_ts = S.SettlingTime;
fprintf(['\\zeta = %f, theoretical Mp value = %f, actual Mp value = %f, theoretical' ...
    ' tr value = %f, actual tr value = %f, theoretical ts value = %f, actual ts value = %f\n'] ...
    ,zeta, theoretical_Mp, actual_mp_percent, theoretical_tr, actual_tr, theoretical_ts, actual_ts);










